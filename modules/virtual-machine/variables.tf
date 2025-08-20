variable "name" {
  description = "The name of the virtual machine"
  type        = string
}

variable "datacenter" {
  description = "The datacenter to use"
  type        = string
}

variable "datastore" {
  description = "The datastore to use"
  type        = string
}

variable "dns_server_list" {
  description = "The DNS servers to use"
  type        = list(string)
  default     = []
}

variable "resource_pool" {
  description = "The resource pool to use"
  type        = string
}

variable "network" {
  description = "The network to use"
  type        = string
}

variable "num_cpus" {
  description = "The number of CPUs to allocate"
  type        = number
}

variable "memory" {
  description = "The amount of memory to allocate"
  type        = number
}

variable "folder" {
  description = "The folder to place the virtual machine in"
  type        = string
}

variable "template" {
  description = "The template to clone"
  type        = string
}

variable "time_zone" {
  description = "The time zone to use"
  type        = string
  default     = "85"
}

variable "linked_clone" {
  description = "Whether to create a linked clone"
  type        = bool
  default     = true
}

variable "ipv4_with_cidr" {
  description = "The IP address of the virtual machine with the cidr"
  type        = string
  default     = null
}

variable "disk_size" {
  description = "The size of the disk in GB. If not provided, uses template disk size."
  type        = number
  default     = null
}
