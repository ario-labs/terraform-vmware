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

  resource_pool   = each.value.resource_pool
  datacenter      = each.value.datacenter
  datastore       = each.value.datastore
  disk_size       = each.value.disk_size
  dns_server_list = each.value.dns_server_list
  folder          = each.value.folder
  ipv4_with_cidr  = each.value.ipv4_with_cidr
  linked_clone    = each.value.linked_clone
  memory          = each.value.memory
  name            = each.value.name
  network         = each.value.network
  num_cpus        = each.value.num_cpus
  template        = each.value.template
  time_zone       = each.value.time_zone
}
