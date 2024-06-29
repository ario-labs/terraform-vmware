terraform {
  required_providers {
    cloudflare = {
      source  = "registry.terraform.io/cloudflare/cloudflare"
      version = "4.36.0"
    }
    vsphere = {
      source  = "registry.terraform.io/hashicorp/vsphere"
      version = "2.8.1"
    }
  }
}
