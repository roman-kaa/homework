data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"
}

resource "yandex_vpc_network" "develop" {
  name = "develop"
}

resource "yandex_vpc_subnet" "develop" {
  name           = "develop-subnet"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.10.10.0/24"]
}

resource "yandex_compute_instance" "web" {
  count = 2

  name        = "web-${count.index + 1}"
  hostname    = "web-${count.index + 1}"
  platform_id = "standard-v3"
  zone        = var.default_zone

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = 10
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    user-data = <<-EOF
      #cloud-config
      datasource:
        Ec2:
          strict_id: false
      ssh_pwauth: no

      users:
        - name: ${var.vm_user}
          sudo: "ALL=(ALL) NOPASSWD:ALL"
          shell: /bin/bash
          ssh_authorized_keys:
            - ${file(var.public_key_path)}

      write_files:
        - path: /usr/local/bin/init-nginx.sh
          permissions: '0755'
          content: |
            #!/bin/bash
            set -e

            apt-get update
            apt-get install -y nginx

            HOSTNAME_VALUE=$(hostname)
            IP_VALUE=$(hostname -I | awk '{print $1}')

            cat > /var/www/html/index.html <<HTML
            <!doctype html>
            <html lang="en">
            <head>
              <meta charset="utf-8">
              <title>Nginx works</title>
            </head>
            <body>
              <h1>Hello from $${HOSTNAME_VALUE}</h1>
              <p>Server name: $${HOSTNAME_VALUE}</p>
              <p>Server IP: $${IP_VALUE}</p>
            </body>
            </html>
            HTML

            systemctl enable nginx
            systemctl restart nginx

      runcmd:
        - ["/usr/local/bin/init-nginx.sh"]
    EOF
  }
}

resource "yandex_lb_target_group" "web_tg" {
  name      = "web-target-group"
  region_id = "ru-central1"

  dynamic "target" {
    for_each = yandex_compute_instance.web
    content {
      subnet_id = yandex_vpc_subnet.develop.id
      address   = target.value.network_interface[0].ip_address
    }
  }
}

resource "yandex_lb_network_load_balancer" "web_nlb" {
  name = "web-nlb"

  listener {
    name = "http-listener"
    port = 80

    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.web_tg.id

    healthcheck {
      name = "http-healthcheck"

      http_options {
        port = 80
        path = "/"
      }
    }
  }
}