# Proxmox Provider
# ---
# Initial Provider Configuration for Proxmox

terraform {

    required_providers {
        proxmox = {
            source = "TheGameProfi/proxmox"
            version = "2.10.0"
        }
    }
}

provider "proxmox" {

    pm_api_url = var.proxmox_api_url
    pm_api_token_id = var.proxmox_api_token_id
    pm_api_token_secret = var.proxmox_api_token_secret
    
    pm_debug = true

    # (Optional) Skip TLS Verification
    # pm_tls_insecure = true

}
