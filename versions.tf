terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.36.0"
    }
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "2.8.1"
    }
  }
}
