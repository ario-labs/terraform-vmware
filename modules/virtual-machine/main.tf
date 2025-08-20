data "vsphere_datacenter" "datacenter" {
  name = var.datacenter
}

data "vsphere_datastore" "datastore" {
  datacenter_id = data.vsphere_datacenter.datacenter.id
  name          = var.datastore
}

data "vsphere_resource_pool" "resource_pool" {
  datacenter_id = data.vsphere_datacenter.datacenter.id
  name          = var.resource_pool
}

data "vsphere_network" "network" {
  datacenter_id = data.vsphere_datacenter.datacenter.id
  name          = var.network
}

data "vsphere_virtual_machine" "template" {
  datacenter_id = data.vsphere_datacenter.datacenter.id
  name          = var.template
}

locals {
  is_windows_template = regex("(?i)windows", data.vsphere_virtual_machine.template.guest_id) != null

  time_zone_map = {
    "America/Chicago" = 20
    "UTC"             = 85
  }
}

resource "vsphere_virtual_machine" "vm" {
  name                   = var.name
  datastore_id           = data.vsphere_datastore.datastore.id
  guest_id               = data.vsphere_virtual_machine.template.guest_id
  resource_pool_id       = data.vsphere_resource_pool.resource_pool.id
  num_cpus               = var.num_cpus
  cpu_hot_add_enabled    = true
  cpu_hot_remove_enabled = true
  memory                 = var.memory
  memory_hot_add_enabled = true
  folder                 = var.folder
  firmware               = "efi"
  lifecycle {
    ignore_changes = [hv_mode, ept_rvi_mode]
  }
  network_interface {
    network_id = data.vsphere_network.network.id
  }
  disk {
    label            = "disk0"
    size             = var.disk_size != null ? var.disk_size : data.vsphere_virtual_machine.template.disks.0.size
    thin_provisioned = true
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    linked_clone  = var.linked_clone
    customize {
      dynamic "windows_options" {
        for_each = local.is_windows_template ? [1] : []
        content {
          computer_name = var.name
          time_zone     = lookup(local.time_zone_map, var.time_zone, 85)
        }
      }
      dynamic "linux_options" {
        for_each = local.is_windows_template ? [] : [1]
        content {
          host_name = var.name
          domain    = ""
        }
      }
      dns_server_list = var.dns_server_list
      network_interface {
        ipv4_address    = split("/", var.ipv4_with_cidr)[0]
        ipv4_netmask    = split("/", var.ipv4_with_cidr)[1]
        dns_server_list = var.dns_server_list
      }
      ipv4_gateway = cidrhost(var.ipv4_with_cidr, 1)
    }
  }
}
