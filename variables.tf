variable "vsphere_user" {
  description = "The username to use when connecting to vSphere"
  type        = string
}

variable "vsphere_password" {
  description = "The password to use when connecting to vSphere"
  type        = string
}

variable "vsphere_server" {
  description = "The vSphere server to connect to"
  type        = string
}

variable "virtual_machines" {
  description = "The list of virtual machines to create"
  type = map(object({
    resource_pool   = string
    datacenter      = string
    datastore       = string
    disk_size       = optional(number)
    dns_server_list = optional(list(string))
    folder          = string
    ipv4_with_cidr  = string
    linked_clone    = optional(bool)
    memory          = number
    name            = string
    network         = string
    num_cpus        = number
    template        = string
    time_zone       = optional(string)
  }))
  default = {}
}
