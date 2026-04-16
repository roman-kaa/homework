output "vm_names" {
  value = [for vm in yandex_compute_instance.web : vm.name]
}

output "vm_internal_ips" {
  value = [for vm in yandex_compute_instance.web : vm.network_interface[0].ip_address]
}

output "vm_external_ips" {
  value = [for vm in yandex_compute_instance.web : vm.network_interface[0].nat_ip_address]
}

output "nlb_ip_address" {
  value = one(flatten([
    for l in yandex_lb_network_load_balancer.web_nlb.listener : [
      for a in l.external_address_spec : a.address
    ]
  ]))
}