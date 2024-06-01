# Proxmox Full-Clone
# ---
# Create a new VM from a clone

resource "proxmox_vm_qemu" "auto-vm" {
    count = var.vm_count
    # VM General Settings
    target_node = var.target_node[count.index % length(var.target_node)]
    vmid = var.vm_id + count.index
    name = format("%s-%d", lower(var.instance_name), count.index +1)

    # VM Advanced General Settings
    onboot = true 

    # VM OS Settings
    clone = var.image[count.index % length(var.image)]
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
    ipconfig0 = format("ip=%s/24,gw=%s", 
                  cidrhost("172.19.255.0/24", 100 + count.index), 
                  var.network_gateway)
    nameserver = join(" ", var.dns_servers)

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

output "vm_info" {
  value = [
    for vm in proxmox_vm_qemu.auto-vm:{
      hostname = vm.name
      ip-addr = vm.default_ipv4_address
      node     = vm.target_node
    }
  ]
}
