# продовый rancher
variable "rancher2_prod_url" { default = "" }
variable "rancher2_prod_access_key" {}
variable "rancher2_prod_secret_key" {}

# продовый vsphere
variable "vsphere_vcenter_url" { default = "" }
variable "vsphere_vcenter_port" { default = "443" }
variable "vsphere_prod_user" {}
variable "vsphere_prod_password" {}

variable "vsphere_prod_admin_user" {}
variable "vsphere_prod_admin_password" {}

variable "vsphere_config_boot2docker_url" {
  default = "https://mirror.local/repository/rancher_start_machine/rancher_start_machine/rancheros-vmware.iso"
}
variable "vsphere_config_engine_install_url" {
  default = "https://mirror.local/repository/rancher_start_machine/rancher_start_machine/20.10.sh"
}
variable "vsphere_config_network" { default = [""] }
variable "vsphere_config_clone_from" { default = "" }
variable "vsphere_config_content_library" { default = "" }
variable "vsphere_config_cfgparam" {
    default = [ "disk.enableUUID=TRUE", "ctkEnabled=TRUE", "mem.hotadd=TRUE", "vcpu.hotadd=TRUE" ]
  }
variable "vsphere_config_folder" { default = "" }
variable "vsphere_config_datacenter" { default = "" }
variable "vsphere_config_pool" { default = "" }
variable "vsphere_config_datastore" { default = "" }
variable "vsphere_config_creation_type" { default = "vm" }

variable "vsphere_cloud_provider_network_public_network" { default = "" }
variable "vsphere_cloud_provider_virtual_center_datacenters" { default = "" }
variable "vsphere_cloud_provider_virtual_center_name" { default = "" }
variable "vsphere_cloud_provider_virtual_center_port" { default = "443" }

variable "vsphere_cloud_provider_workspace_default_datastore" { default = "" }
variable "vsphere_cloud_provider_workspace_default_datacenter" { default = "" }
variable "vsphere_cloud_provider_workspace_folder" { default = "" }
variable "vsphere_cloud_provider_workspace_server" { default = "" }
variable "vsphere_cloud_provider_workspace_resourcepool_path" { default = "" }

variable "rke_config_kubernetes_version" { default = "v1.22.13-rancher1-1" }
variable "rke_config_network_plugin" { default = "calico" }

variable "rke_config_private_registries" { default = "mirror.local" }
