terraform {
  required_providers {
    rancher2 = {
      source = "rancher/rancher2"
      version = "1.24.0"
    }
    vsphere = {
      source = "hashicorp/vsphere"
      version = "2.2.0"
    }
  }
}

provider "rancher2" {
  api_url    = var.rancher2_prod_url
  access_key = var.rancher2_prod_access_key
  secret_key = var.rancher2_prod_secret_key
}
