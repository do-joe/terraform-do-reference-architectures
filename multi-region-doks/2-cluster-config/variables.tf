variable "name_prefix" {
  description = "prefix used for the resources created in this module"
  type        = string
}

variable "primary_region" {
  description = "DO region slug for the primary region"
  type        = string
}

variable "secondary_region" {
  description = "DO region slug for the secondary region"
  type        = string
}

variable "igw_count" {
  description = "Number of Inet GW droplet"
  type        = number
  default     = 0
}

variable "igw_size" {
  description = "DO size slug used for the Inet GW droplet"
  type        = string
}

variable "igw_image" {
  description = "DO image slug to run on the Inet GW droplet, must be ubuntu based."
  type        = string
}

variable "igw_ssh_keys" {
  description = "A list of SSH key IDs or fingerprints to enable on the Inet GW droplet in the format [12345, 123456]"
  type        = list(number)
  default = []
}
