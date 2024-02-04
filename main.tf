# Proxmox Full-Clone
# ---
# Create a new VM from a clone

resource "proxmox_vm_qemu" "auto-vm" {
    
    # VM General Settings
    target_node = "pve-server"
    vmid = "102"
    name = "vm-coba"

    # VM Advanced General Settings
    onboot = true 

    # VM OS Settings
    clone = "ubuntu-22"
    full_clone = true

    # VM System Settings
    agent = 0
    
    # VM CPU Settings
    cores = 1
    sockets = 1
    cpu = "kvm64"    
    
    # VM Memory Settings
    memory = 1024

    # VM Network Settings
    network {
        bridge = "vmbr1"
        model  = "virtio"
    }
    ipconfig0 = "ip=dhcp"

    # VM Disk Settings
    bootdisk = "scsi0"
    scsihw = "virtio-scsi-pci"

    disks {
      scsi {
        scsi0 {
            disk {
            size = 20
            storage = "local-lvm"
          }
        }
      }
    }
    
    # VM Cloud-Init Settings
    os_type = "cloud-init"
    cloudinit_cdrom_storage = "local-lvm"
    
    ciuser = var.ci_user
    cipassword = var.ci_password
    # sshkeys = var.sshkeys
    sshkeys = <<EOF
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDvs8uuUuAYKXMG3VcsmOP+opv9/1jC48uyDdBpyHnmVxVYqg7dYFOvaFEG3RLiP8pyqFt5hvUNSIJQaXvYN94ShXUxBj7petAJflX277k7R+R6vqXFZVZrUiMxhW83KN3A3MU+D0ayPVw9K9l4wRBwTDUuWIIxcrLVpFyIN0KUUtzg2ChUsnJWr3TrrEuP1i+obv+R+KHqUbr3vCX8xL1bOI9S3N08xHxX0aS705pv52IcQ2lfRwVLlZ8ryLPpfV5QZgi/93ieV1OBXfv8vHYXJ5WeU/1nVdGdTLLy4bRdmWwrUb/XNZI1OU3hfXHb2T/6xu1/8xXeI98yvcBbrxYr root@pve
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDVb1jMFd2rj/kXMGsiDqR6XIgew0OkctwhRk4Wm9yHY9SvB8dugOOhvLsDw9LCGXfhKjkb30MoSzHAcsUwJeSnVgerCKlAQW+SLpoKajFNEtsGGxDWv0+ORT30Ek68aZDvLCOFdDTD8obOt1CBvq+0d714ADWcYRkiwAHH61ShRHuSXJOlV/pdNAP+oXUdCVR58kQhGCRdOQO2e1RzaQEQjKtX/TDj2Q7T7jeLXiMT+f2V19R0pPlMuZyRXtfFffJSMIXZYYLLPOCkOy5uJhdfC2GwUPZA8DY0Sl7cR9XCyJzttpFv8IHfSi7WTziO4A5MIvHMN4IwQW2fsG51PQlHBFZdhhoAlIUA8Ojevd4YsKyeyMIpj6RN+djxX1b4MmHjd3+B/NIfhG5iYQRQKAgWpbw9/PYgwuCQM8GP5dvEs5lmNDwkpLq5BPX0Ikb6w6QmVG1MnESuYRwlrOA+nneY/AY3ZK627g60o5MiWgCeKr3gAhd4O9WKNB1ZhvUhLF8= avnanrahman@gmail.com
    EOF

    lifecycle {
      ignore_changes = [ 
        network
       ]
    }
}
