variable "cnt_vault" {
  description = "Number of Vault Servers to create"
  type        = number
  default     = 3
}

variable "lxd_storage_pool" {
  description = "Override the LXD Storage Pool to use"
  type        = string
  default     = "data01"
}

variable "lxd_profiles" {
  description = "Override the LXD Container Profiles to use"
  type        = list(string)
  default     = []
}
