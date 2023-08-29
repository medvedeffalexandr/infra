Terrafrom vcenter module
=========================

Variables required to use the module:
- `folder` - vmvare folder
- `env` - name of environment (used in dns records and vshpere vm name)
- `network` - vmvare network
- `hostname` - vm hostname
- `vm_name` - vm name
- `net_interfaces` - list of network interfaces
Example:
```
  net_interfaces = [
    { net = "Dev Network", ip = "dhcp" },
    { net = "new_dev_network", ip = "172.28.15.250/24" }
  ]
```
- `ip_gateway` - ip of default ip gateway (default null)
- `dns_server_list` - ips of dns servers (default ["172.28.8.2","172.28.1.2","172.28.1.21"])
- `persistent_disks` - list of persistent disks
- `num_cpu` - num of vcpu (default 2)
- `ram` - ammount of ram (default 1024)
- `root_size` - size of rootfs (default 29Gb)
- `nested_virtualization` - enable nested virtualisation on VM (default: false)


- `dns_server` - ip addres of dns server (for dns provider) (default "172.28.8.2","172.28.1.2","172.28.1.21")
- `dns_zone` - dynamic dns zone ( default "inno.tech.")
