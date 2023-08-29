output "vm-info" {
  value = {
    ip_default = "${vsphere_virtual_machine.vm.default_ip_address}"
    ip_all     = "${vsphere_virtual_machine.vm.guest_ip_addresses}"
  }
}
