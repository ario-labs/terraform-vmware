terraform {
  backend "s3" {}
}

provider "vsphere" {
  vsphere_server       = var.vsphere_server
  user                 = var.vsphere_user
  password             = var.vsphere_password
  allow_unverified_ssl = true
}

module "virtual-machine" {
  for_each = var.virtual_machines

  source = "./modules/virtual-machine"

  providers = {
    vsphere = vsphere
  }

  name           = each.value.name
  cluster        = each.value.cluster
  datastore      = each.value.datastore
  datacenter     = each.value.datacenter
  network        = each.value.network
  num_cpus       = each.value.num_cpus
  memory         = each.value.memory
  folder         = each.value.folder
  template       = each.value.template
  ipv4_with_cidr = each.value.ipv4_with_cidr
}
