#!/bin/bash
# Jumlah total VM yang sudah dibuat
TOTAL_VM=12
# Jumlah VM per folder
VM_PER_FOLDER=2
# Nama VM
VM_NAME="vm-batch"
# Nama folder dasar
FOLDER_BASE="/home/ubuntu/terraform-proxmox"
FOLDER_BATCH="terraform_batch"


# Loop untuk menjalankan terraform apply di setiap folder
for i in $(seq 0 $((TOTAL_VM / VM_PER_FOLDER - 1)))
do
  # Tentukan nama folder
  FOLDER_NAME="${FOLDER_BATCH}_$((i+1))"

  # Menentukan nama vm
  INSTANCE_NAME="${VM_NAME}-$((i+1))"
  
  # Hitung vm_id awal untuk batch ini
  VM_ID_START=$((200 + i * VM_PER_FOLDER))

  # Start vm_ip untuk batch ini
  VM_IP=$((100 + i * VM_PER_FOLDER))

  # Masuk ke folder
  cd "${FOLDER_BASE}/${FOLDER_NAME}"

  # Jalankan terraform apply dengan variabel yang ditetapkan dari baris perintah
  terraform destroy --auto-approve -var "instance_name=${INSTANCE_NAME}" -var "vm_count=${VM_PER_FOLDER}" -var "vm_id=${VM_ID_START}" -var "vm_ip=${VM_IP}" -var "batch=${i}"
done
