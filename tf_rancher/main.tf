resource "rancher2_cloud_credential" "vsphere_credential" {
  name = "vsphere_credential"
  description = "vsphere_credential"
  vsphere_credential_config {
    username = var.vsphere_prod_admin_user
    password = var.vsphere_prod_admin_password
    vcenter = var.vsphere_vcenter_url
    vcenter_port = var.vsphere_vcenter_port
  }
}

resource "rancher2_node_template" "master" {
  name = "master"
  cloud_credential_id = rancher2_cloud_credential.vsphere_credential.id
  vsphere_config {
    datacenter = var.vsphere_config_datacenter
    pool = var.vsphere_config_pool
    datastore = var.vsphere_config_datastore
    folder = var.vsphere_config_folder
    cpu_count = "4"
    memory_size = "8192"
    disk_size = "51200"
    creation_type = var.vsphere_config_creation_type
    content_library = var.vsphere_config_content_library
    clone_from = var.vsphere_config_clone_from
    cloud_config = file("files/cloud_config/master.yaml")
    network = var.vsphere_config_network
    cfgparam = var.vsphere_config_cfgparam
    boot2docker_url = var.vsphere_config_boot2docker_url
  }
  engine_install_url = var.vsphere_config_engine_install_url
}

resource "rancher2_node_template" "worker" {
  name = "worker"
  cloud_credential_id = rancher2_cloud_credential.vsphere_credential.id
  vsphere_config {
    datacenter = var.vsphere_config_datacenter
    pool = var.vsphere_config_pool
    datastore = var.vsphere_config_datastore
    folder = var.vsphere_config_folder
    cpu_count = "4"
    memory_size = "16384"
    disk_size = "102400"
    creation_type = var.vsphere_config_creation_type
    content_library = var.vsphere_config_content_library
    clone_from = var.vsphere_config_clone_from
    cloud_config = file("files/cloud_config/worker.yaml")
    network = var.vsphere_config_network
    cfgparam = var.vsphere_config_cfgparam
    boot2docker_url = var.vsphere_config_boot2docker_url
  }
  engine_install_url = var.vsphere_config_engine_install_url
}

resource "rancher2_node_template" "ingress" {
  name = "ingress"
  cloud_credential_id = rancher2_cloud_credential.vsphere_credential.id
  vsphere_config {
    datacenter = var.vsphere_config_datacenter
    pool = var.vsphere_config_pool
    datastore = var.vsphere_config_datastore
    folder = var.vsphere_config_folder
    cpu_count = "2"
    memory_size = "4096"
    disk_size = "51200"
    creation_type = var.vsphere_config_creation_type
    content_library = var.vsphere_config_content_library
    clone_from = var.vsphere_config_clone_from
    cloud_config = file("files/cloud_config/ingress.yaml")
    network = var.vsphere_config_network
    cfgparam = var.vsphere_config_cfgparam
    boot2docker_url = var.vsphere_config_boot2docker_url
  }
  engine_install_url = var.vsphere_config_engine_install_url
}

resource "rancher2_node_pool" "master" {
  cluster_id =  rancher2_cluster.cluster.id
  name = "master"
  hostname_prefix =  "master"
  node_template_id = rancher2_node_template.master.id
  quantity = 3
  control_plane = true
  etcd = true
  worker = false
}

resource "rancher2_node_pool" "worker" {
  cluster_id =  rancher2_cluster.cluster.id
  name = "worker"
  hostname_prefix =  "worker"
  node_template_id = rancher2_node_template.worker.id
  quantity = 4
  control_plane = false
  etcd = false
  worker = true
}

resource "rancher2_node_pool" "ingress" {
  cluster_id =  rancher2_cluster.cluster.id
  name = "ingress"
  hostname_prefix =  "ingress"
  node_template_id = rancher2_node_template.ingress.id
  quantity = 2
  control_plane = false
  etcd = false
  worker = true
  node_taints {
    key    = "node-role.kubernetes.io/ingress"
    value  = "ingress"
    effect = "NoExecute"
  }
  node_taints {
    key    = "node-role.kubernetes.io/ingress"
    value  = "ingress"
    effect = "NoSchedule"
  }
}

resource "rancher2_cluster_sync" "cluster_sync" {
  cluster_id =  rancher2_cluster.cluster.id
  node_pool_ids = [
    rancher2_node_pool.ingress.id,
    rancher2_node_pool.master.id,
    rancher2_node_pool.worker.id,
    rancher2_node_template.ingress.id,
    rancher2_node_template.master.id,
    rancher2_node_template.worker.id,
    rancher2_cloud_credential.vsphere_credential.id
  ]
}

resource "rancher2_cluster" "cluster" {
  name = "cluster"
  rke_config {
    kubernetes_version = var.rke_config_kubernetes_version
    network {
      plugin = var.rke_config_network_plugin
    }
    ingress {
      node_selector = {
        "node-role.kubernetes.io/ingress" = "ingress"
      }
      http_port = 80
      https_port = 443
    }
    private_registries {
      url = var.rke_config_private_registries
      is_default = true
    }
    cloud_provider {
      vsphere_cloud_provider {
        network {
          public_network = var.vsphere_cloud_provider_network_public_network
        }
        virtual_center {
          datacenters = var.vsphere_cloud_provider_virtual_center_datacenters
          name        = var.vsphere_cloud_provider_virtual_center_name
          user        = var.vsphere_prod_user
          password    = var.vsphere_prod_password
          port        = var.vsphere_cloud_provider_virtual_center_port
        }
        workspace {
          default_datastore = var.vsphere_cloud_provider_workspace_default_datastore
          datacenter        = var.vsphere_cloud_provider_workspace_default_datacenter
          folder            = var.vsphere_cloud_provider_workspace_folder
          server            = var.vsphere_cloud_provider_workspace_server
          resourcepool_path = var.vsphere_cloud_provider_workspace_resourcepool_path
        }
      }
    }
  }
  enable_cluster_monitoring = false
  enable_cluster_alerting = false
}
