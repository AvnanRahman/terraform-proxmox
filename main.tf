# Proxmox Full-Clone
# ---
# Create a new VM from a clone
resource "random_password" "vm_password" {
  count   = var.vm_count
  length  = 8
  special = true
}

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
    memory = 512

    # VM Network Settings
    network {
        bridge = "vmbr1"
        model  = "virtio"
    }
    ipconfig0 = format("ip=%s/24,gw=%s", 
                  cidrhost("172.19.255.0/24", var.vm_ip + count.index), 
                  var.network_gateway)
    nameserver = join(" ", var.dns_servers)

    # VM Disk Settings
    bootdisk = "scsi0"
    scsihw = "virtio-scsi-pci"

    disks {
      scsi {
        scsi0 {
            disk {
            size = 10
            storage = "local-lvm"
          }
        }
      }
    }
    
    # VM Cloud-Init Settings
    os_type = "cloud-init"
    cloudinit_cdrom_storage = "local-lvm"
    
    ciuser = var.ci_user
    cipassword = random_password.vm_password[count.index].result
    sshkeys = var.sshkeys

    lifecycle {
      ignore_changes = [ 
        network
       ]
    }
}

# Output untuk informasi VM tanpa menampilkan password
output "vm_info" {
  value = [
    for vm in proxmox_vm_qemu.auto-vm:{
      hostname = vm.name
      ip-addr = vm.default_ipv4_address
      node     = vm.target_node
    }
  ]
}

# Menyimpan informasi sensitif dalam variabel
output "vm_passwords" {
  value = [
    for vm in proxmox_vm_qemu.auto-vm : {
      hostname = vm.name
      password = vm.cipassword
    }
  ]
  sensitive = true
}

# Resource untuk menyimpan informasi VM ke dalam file
resource "local_file" "vm_info" {
  content = join("\n", [
    for vm in proxmox_vm_qemu.auto-vm : format("Hostname: %s, IP: %s, Node: %s, Password: %s", 
    vm.name, vm.default_ipv4_address, vm.target_node, vm.cipassword)
  ])
  filename = "/home/ubuntu/terraform-proxmox/{var.batch}/vm_info.txt"
}
