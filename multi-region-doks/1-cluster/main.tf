terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.50"
    }
  }
}

module "multi_region_vpc" {
  source             = "git@github.com:do-joe/terraform-do-multi-region-vpc.git"
  name_prefix        = var.name_prefix
  primary_region     = var.primary_region
  primary_ip_range   = var.primary_vpc_ip_range
  secondary_region   = var.secondary_region
  secondary_ip_range = var.secondary_vpc_ip_range
}

resource "digitalocean_kubernetes_cluster" "primary_cluster" {
  name                             = "${var.name_prefix}-${var.primary_region}"
  tags                             = [var.name_prefix]
  region                           = var.primary_region
  version                          = var.doks_version
  cluster_subnet                   = var.primary_pod_ip_range
  service_subnet                   = var.primary_service_ip_range
  vpc_uuid                         = module.multi_region_vpc.primary_vpc_id
  auto_upgrade                     = var.doks_auto_upgrade
  destroy_all_associated_resources = var.doks_destroy_all_associated_resources
  ha                               = var.doks_ha
  registry_integration             = var.doks_registry_integration
  routing_agent {
    enabled = var.doks_routing_agent
  }
  node_pool {
    name       = "${var.name_prefix}-${var.primary_region}-${var.node_pool_name}"
    size       = var.node_pool_size
    auto_scale = true
    min_nodes  = var.node_pool_min
    max_nodes  = var.node_pool_max
    tags       = [var.name_prefix]
  }
}

resource "digitalocean_kubernetes_cluster" "secondary_cluster" {
  name                             = "${var.name_prefix}-${var.secondary_region}"
  tags                             = [var.name_prefix]
  region                           = var.secondary_region
  version                          = var.doks_version
  cluster_subnet                   = var.secondary_pod_ip_range
  service_subnet                   = var.secondary_service_ip_range
  vpc_uuid                         = module.multi_region_vpc.secondary_vpc_id
  auto_upgrade                     = var.doks_auto_upgrade
  destroy_all_associated_resources = var.doks_destroy_all_associated_resources
  ha                               = var.doks_ha
  registry_integration             = var.doks_registry_integration
  routing_agent {
    enabled = var.doks_routing_agent
  }
  node_pool {
    name       = "${var.name_prefix}-${var.secondary_region}-${var.node_pool_name}"
    size       = var.node_pool_size
    auto_scale = true
    min_nodes  = var.node_pool_min
    max_nodes  = var.node_pool_max
    tags       = [var.name_prefix]
  }
}

