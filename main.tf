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
    clone = "ubuntu-template"
    full_clone = true

    # VM System Settings
    agent = 1
    
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
            size = 25
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
    sshkeys = var.sshkeys

    lifecycle {
      ignore_changes = [ 
        network
       ]
    }
}
