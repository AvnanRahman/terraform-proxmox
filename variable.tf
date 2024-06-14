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

variable "batch" {
  type = number
}

variable "vm_cpu" {
  type = number
  description = "Masukkan jumlah vCPU"
}

variable "vm_memory" {
  type = number
  description = "Masukkan jumlah memory dalam satuan MB"
}

variable "vm_disk" {
  type = number
  description = "Masukkan jumlah storage dalam satuan GB"
}

variable "ci_user" {
  type = string
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

variable "image" {
  type = list(string)
  description = "Daftar image template sesuai node."
  default = [ "ubuntu-22"]
}

variable "vm_id" {
  type = number
  description = "Masukkan nilai VM ID instance pertama:"
  validation {
    condition     = var.vm_id > 0
    error_message = "Nilai VM ID (vm_id) harus berupa angka positif yang lebih besar dari 0."
  }
}

variable "vm_count" {
  type = number
  description = "Masukkan jumlah VM yang ingin Anda buat, misalnya: 3."
  validation {
    condition     = var.vm_count > 0
    error_message = "Jumlah VM (vm_count) harus berupa angka positif yang lebih besar dari 0."
  }
}

variable "vm_ip" {
  type = number
  description = "Masukkan IP Address VM pertama, cukup masukan IP Host dari network 172.19.255.0/24."
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