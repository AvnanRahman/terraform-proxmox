#!/bin/bash
# Jumlah total VM yang ingin dibuat
TOTAL_VM=36
# Jumlah VM per folder
VM_PER_FOLDER=6 # Max 6, jangan dirubah
# Nama folder dasar
FOLDER_BASE="/home/ubuntu/terraform-proxmox"
FOLDER_BATCH="terraform_batch"

# Loop untuk membuat folder dan menyalin file terraform
for i in $(seq 0 $((TOTAL_VM / VM_PER_FOLDER - 1)))
do
  # Tentukan nama folder
  FOLDER_NAME="${FOLDER_BATCH}_$((i+1))"

  # Buat folder
  cd "$FOLDER_BASE"
  mkdir -p "$FOLDER_NAME"

  # Salin file terraform ke folder baru
  cp /home/ubuntu/terraform-proxmox/*.tf "$FOLDER_NAME"
  cp /home/ubuntu/terraform-proxmox/*.tfvars "${FOLDER_NAME}"

  # Terraform Init

  cd "${FOLDER_BASE}/${FOLDER_NAME}" && terraform init
done