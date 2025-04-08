terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.50"
    }
  kubernetes = {
    source  = "hashicorp/kubernetes"
    version = "~> 2.0"
  }
  }
}


data "digitalocean_vpc" "primary" {
  name = "${var.name_prefix}-${var.primary_region}"
}

module "primary_igw" {
  source      = "git@github.com:do-joe/terraform-do-droplet-internet-gateway.git"
  name_prefix = var.name_prefix
  igw_count = var.igw_count
  region      = var.primary_region
  size        = var.igw_size
  image       = var.igw_image
  vpc_id      = data.digitalocean_vpc.primary.id
  ssh_keys    = var.igw_ssh_keys
  tags        = [var.name_prefix]
  doks_cluster_name = "${var.name_prefix}-${var.primary_region}"
}

module "primary-lb" {
  source = "git@github.com:do-joe/terraform-do-doks-lbaas.git"
  doks_cluster_name = "${var.name_prefix}-${var.primary_region}"
  lb_size_unit = 2
}

data "digitalocean_vpc" "secondary" {
  name = "${var.name_prefix}-${var.secondary_region}"
}

module "secondary_igw" {
  source      = "git@github.com:do-joe/terraform-do-droplet-internet-gateway.git"
  name_prefix = var.name_prefix
  igw_count = var.igw_count
  region      = var.secondary_region
  size        = var.igw_size
  image       = var.igw_image
  vpc_id      = data.digitalocean_vpc.secondary.id
  ssh_keys    = var.igw_ssh_keys
  tags        = [var.name_prefix]
  doks_cluster_name = "${var.name_prefix}-${var.secondary_region}"
}

module "secondary-lb" {
  source = "git@github.com:do-joe/terraform-do-doks-lbaas.git"
  doks_cluster_name = "${var.name_prefix}-${var.secondary_region}"
  lb_size_unit = 2
}
