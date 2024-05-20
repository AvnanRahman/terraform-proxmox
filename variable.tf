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
  type = string
  description = "Masukkan target node:"
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