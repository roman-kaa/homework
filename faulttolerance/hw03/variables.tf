variable "yc_token" {
  type        = string
  sensitive   = true
  description = "Yandex Cloud token"
}

variable "yc_cloud_id" {
  type        = string
  description = "Yandex Cloud ID"
}

variable "yc_folder_id" {
  type        = string
  description = "Yandex Folder ID"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "Default zone"
}

variable "vm_user" {
  type        = string
  default     = "ubuntu"
  description = "VM user"
}

variable "public_key_path" {
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
  description = "Path to SSH public key"
}