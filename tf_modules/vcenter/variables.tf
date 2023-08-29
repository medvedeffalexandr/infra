variable "datacenter" {
  default     = ""
  description = "vsphere datacenter"
}

variable "vsphere_cluster" {
  default     = ""
  description = "vsphere cluster name"
}

variable "datastore" {
  default     = ""
  description = "vsphere storage"
}

variable "folder" {
  default     = ""
  description = "VM location in vspehre"
}

variable "hostname" {
  default     = ""
  description = "vm hostname"
}

variable "vm_name" {
  default     = null
  description = "vsphere VM name"
}

variable "template" {
  default     = ""
  description = "vpshere VM template"
}

variable "net_interfaces" {}

variable "ip_gateway" {
  default = null
}

variable "dns_server_list" {
  type = list(any)
  default = [
    "10.0.0.1",
    "10.0.0.2"
  ]
}

variable "persistent_disks" {
  default = []
}

variable "num_cpu" {
  default = "2"
}

variable "cpu_limit" {
  default = null
}

variable "ram" {
  default = "1024"
}

variable "root_size" {
  default = "64"
}

variable "domain" {
  default = "test.local"
}

variable "user_data" {
    default = ""
}
