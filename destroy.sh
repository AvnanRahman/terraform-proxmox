#!/bin/bash
##--- Variabel yang tidak perlu dirubah ---##
# Jumlah VM per folder
VM_PER_FOLDER=6 # Max 6, jangan dirubah
# Nama folder dasar
FOLDER_BASE="/home/ubuntu/terraform-proxmox"
FOLDER_BATCH="terraform_batch"
##-----------------------------------------##
##--- Variabel yang perlu dirubah ---##
# Jumlah total VM yang sudah dibuat
TOTAL_VM=1
# Variabel VM
VM_NAME="vm-batch"
VM_ID=200
VM_IP=100 # Digit ke-4 dari network IP
VM_CORE=1
VM_MEMORY=512 # Dalam satuan MB
VM_DISK=10 # Dalam satuan GB
##-----------------------------------------##

# Hitung jumlah batch yang diperlukan
NUM_BATCHES=$(( (TOTAL_VM + VM_PER_FOLDER - 1) / VM_PER_FOLDER ))

# Loop untuk menjalankan terraform destroy di setiap folder
for i in $(seq 0 $((NUM_BATCHES - 1)))
do
  # Tentukan nama folder
  FOLDER_NAME="${FOLDER_BATCH}_$((i+1))"

  # Menentukan nama vm
  VM_BATCH_NAME="${VM_NAME}-$((i+1))"
  
  # Hitung vm_id awal untuk batch ini
  VM_BATCH_ID=$((${VM_ID} + i * VM_PER_FOLDER))

  # Start vm_ip untuk batch ini
  VM_BATCH_IP=$((${VM_IP} + i * VM_PER_FOLDER))

  # Hitung jumlah VM untuk batch ini
  if [ $((i + 1)) -eq $NUM_BATCHES ]; then
    VM_BATCH_COUNT=$((TOTAL_VM - i * VM_PER_FOLDER))
  else
    VM_BATCH_COUNT=$VM_PER_FOLDER
  fi

  # Masuk ke folder
  cd "${FOLDER_BASE}/${FOLDER_NAME}"

  # Jalankan terraform apply dengan variabel yang ditetapkan dari baris perintah
  terraform destroy --auto-approve -var "instance_name=${VM_BATCH_NAME}" -var "vm_count=${VM_BATCH_COUNT}" -var "vm_id=${VM_BATCH_ID}" -var "vm_ip=${VM_BATCH_IP}" -var "batch=${i}" -var "vm_cpu=${VM_CORE}" -var "vm_memory=${VM_MEMORY}" -var "vm_disk=${VM_DISK}"

  # Cleanup Folder
  rm -rfv "${FOLDER_BASE}/${FOLDER_NAME}"
done
