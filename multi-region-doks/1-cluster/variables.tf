variable "name_prefix" {
  description = "prefix used for the resources created in this module"
  type        = string
}

variable "primary_region" {
  description = "DO region slug for the primary region"
  type        = string
}

variable "primary_vpc_ip_range" {
  description = "CIDR notation for subnet used for primary region VPC"
  type        = string
  nullable    = true
  default     = null
}

variable "secondary_region" {
  description = "DO region slug for the secondary region"
  type        = string
}

variable "primary_pod_ip_range" {
  description = "CIDR notation for the subnet used for pod IPs in the primary region"
  type        = string
}

variable "primary_service_ip_range" {
  description = "CIDR notation for the subnet used for service IPs in the primary region"
  type        = string
}

variable "secondary_vpc_ip_range" {
  description = "CIDR notation for subnet used for secondary region VPC"
  type        = string
  nullable    = true
  default     = null
}

variable "secondary_pod_ip_range" {
  description = "CIDR notation for the subnet used for pod IPs in the secondary region"
  type        = string
}

variable "secondary_service_ip_range" {
  description = "CIDR notation for the subnet used for service IPs in the secondary region"
  type        = string
}

variable "doks_version" {
  description = "Version to use for DOKS clusters"
  type        = string
}

variable "doks_auto_upgrade" {
  description = "If auto upgrade is configured for DOKS clusters"
  type        = bool
  default     = false
}

variable "doks_ha" {
  description = "If DOKS clusters deploy with HA control plane"
  type        = bool
  default     = true
}

variable "doks_destroy_all_associated_resources" {
  description = "If all resources created via the Kubernetes API (load balancers, volumes, and volume snapshots) will be destroyed"
  type        = bool
  default     = false
}

variable "doks_registry_integration" {
  description = "If DOKS clusters deployed with DOCR integration. Requires DOCR to be enabled within the team"
  type        = bool
  default     = false
}

variable "doks_routing_agent" {
  description = "If DOKS clusters deployed with routing agent enabled"
  type        = bool
  default     = false
}

variable "node_pool_name" {
  description = "Name of the first node pool created for the DOKS cluster"
  type        = string
  default     = "default"
}

variable "node_pool_size" {
  description = "slug identifier for the type of Droplet"
  type        = string
}

variable "node_pool_min" {
  description = "Min number of nodes to include in the node pool"
  type        = number
}

variable "node_pool_max" {
  description = "Max number of nodes to include in the node pool"
  type        = number
}

