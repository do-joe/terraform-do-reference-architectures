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
  source      = "../../../terraform-do-droplet-internet-gateway"
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

data "digitalocean_vpc" "secondary" {
  name = "${var.name_prefix}-${var.secondary_region}"
}

module "secondary_igw" {
  source      = "../../../terraform-do-droplet-internet-gateway"
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

