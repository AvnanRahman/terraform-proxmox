#!/bin/bash
##--- Variabel yang tidak perlu dirubah ---##
# Jumlah VM per folder
VM_PER_FOLDER=6 # Max 6, jangan dirubah
# Nama folder dasar
FOLDER_BASE="/home/ubuntu/terraform-proxmox"
FOLDER_BATCH="terraform_batch"
##-----------------------------------------##
##--- Variabel yang perlu dirubah ---##
# Jumlah total VM yang ingin dibuat
TOTAL_VM=1
##-----------------------------------------##

# Hitung jumlah batch yang diperlukan
NUM_BATCHES=$(( (TOTAL_VM + VM_PER_FOLDER - 1) / VM_PER_FOLDER ))

# Loop untuk membuat folder, menyalin file terraform, dan menjalankan terraform init
for i in $(seq 0 $((NUM_BATCHES - 1)))
do
  # Tentukan nama folder
  FOLDER_NAME="${FOLDER_BATCH}_$((i+1))"

  # Buat folder
  cd "$FOLDER_BASE"
  mkdir -v -p "$FOLDER_NAME"

  # Salin file terraform ke folder baru
  cp -v /home/ubuntu/terraform-proxmox/*.tf "$FOLDER_NAME"
  cp -v /home/ubuntu/terraform-proxmox/*.tfvars "${FOLDER_NAME}"

  # Terraform Init
  cd "${FOLDER_BASE}/${FOLDER_NAME}" && terraform init
done