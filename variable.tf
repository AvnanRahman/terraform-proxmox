variable "proxmox_api_url" {
    type = string
}

variable "proxmox_api_token_id" {
    type = string
    sensitive = true
}

variable "proxmox_api_token_secret" {
    type = string
    sensitive = true
}

variable "ci_user" {
  type = string
}

variable "ci_password" {
  type = string
  sensitive = true
}

variable "sshkeys" {
  type = string
}
variable "target_node" {
  type = list(string)
  description = "Daftar node Proxmox."
  default = [ "pve-server" ]
}

variable "instance_name" {
  type = string
  description = "Masukkan nama awal untuk VM:"
}
variable "vm_id" {
  type = number
  description = "Masukkan nilai VM ID instance pertama:"
}

variable "vm_count" {
  type = number
  description = "Masukkan jumlah VM yang ingin Anda buat, misalnya: 3."
}

variable "network_gateway" {
  type = string
  description = "IP gateway untuk network."
  default = "172.19.255.254"
}

variable "dns_servers" {
  type = list(string)
  description = "Daftar DNS servers."
  default = ["8.8.8.8", "8.8.4.4"]
}