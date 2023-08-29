locals {
  module_version = "0.0.0"
}

data "vsphere_datacenter" "datacenter" {
  name = var.datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.vsphere_cluster
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "net" {
  count         = length(var.net_interfaces)
  name          = var.net_interfaces[count.index].net
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.template
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

resource "vsphere_virtual_machine" "vm" {
  name             = var.vm_name
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder           = var.folder

  num_cpus               = var.num_cpu
  cpu_limit              = var.cpu_limit
  memory                 = var.ram
  guest_id               = data.vsphere_virtual_machine.template.guest_id

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = var.hostname
        domain    = var.domain
      }

      dynamic "network_interface" {
        for_each = [for interface in var.net_interfaces : {
          ip = interface.ip
        }]
        content {
          ipv4_address = network_interface.value.ip != "dhcp" ? element(split("/", network_interface.value.ip), 0) : null
          ipv4_netmask = network_interface.value.ip != "dhcp" ? element(split("/", network_interface.value.ip), 1) : null
        }
      }

      ipv4_gateway    = var.ip_gateway
      dns_server_list = var.dns_server_list
    }
  }

  dynamic "network_interface" {
    for_each = data.vsphere_network.net
    content {
      network_id = network_interface.value.id
    }
  }

  disk {
    datastore_id = data.vsphere_datastore.datastore.id
    label        = "root"
    size         = var.root_size
  }

  vapp {
    properties = {
      user-data = var.user_data
    }
  }

  cdrom {
    client_device = true
  }

}
