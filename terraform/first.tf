terraform {
  required_providers {
    lxd = {
      source = "terraform-lxd/lxd"
      version = "2.5.0"
    }
    ansible = {
      source  = "ansible/ansible"
      version = "1.3.0"
    }
  }
}

provider "ansible" {
  # Configuration options
}

provider "lxd" {
  # Configuration options
}

variable "cnt_vault" {
  description = "Number of Vault Servers to create"
  type        = number
  default     = 3
}

data "lxd_network" "lxdbr0" {
  name = "lxdbr0"
}

data "lxd_storage_pool" "default" {
  name = "default"
}

data "lxd_profile" "profile01" {
  name = "profile01"
}

# resource "lxd_profile" "profile01" {
#   name = "profile01"
# 
#   config = {
#     "limits.cpu"                 = 2
#     "cloud-init.ssh-keys.id_rsa" = "root:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDpVMvtV6G9aXJctL2IbE6hZT9oIqHAlhb/KPEZYMfyy79qDvQm3nt+KRV9tM1YGili14XX4XVBQ5Zz6UkW4+31LhfVSwOoB0Qb1GdoUfMts5CyKT3eIu6wiRvhkN/qQjKvrY0hA2O9yO4RaEglv6n+knxI5DXkR+DQeuJzHnigl53cbl8CEdQZwgDcZ/O/hM5CkAxRIWUrk913Mo2U8XAmulMUiwDMDRiZvG/HpiUbzA0p/NECZHoTuxbrP2tTD5wqwSxMIVQZ1lPmQNqH43dyjrgpznxj9oOPy2F/pYgamv+ojoJiWU2WY8sb1bjo1tIzp1WdckEtvkYHGii45Q2CM8f6aYzzs+pgtmI9qR0DjHShokxTrAJXvLGNeQcXc7WkoEHrFE0/uAPhAoHPWpNwqT/W3pVMA57vnlsFLJxiEuc4+655s8MJKgMTaXPOdSjvou++D/okB6eayv+eJQsu1lbHRJn0kWtJrjJJhIc7rsO3onsV0JT8/ooonUzJUH0= work@DESKTOP-GQT59S3"
#   }
# 
#   device {
#     type = "disk"
#     name = "root"
#     properties = {
#       pool = data.lxd_storage_pool.default.name
#       path = "/"
#     }
#   }
# 
#   device {
#     name = "eth0"
#     type = "nic"
#     properties = {
#       network = data.lxd_network.lxdbr0.name
#     }
# 
#   }
# 
# }

resource "lxd_profile" "profile_vault" {
  name = "profile_vault"
  config = {
    "user.app" = "Vault"
  }
}

resource "lxd_instance" "vaults" {
  count    = var.cnt_vault
  name     = format("vault%02d", count.index + 1)
  profiles = [data.lxd_profile.profile01.name, lxd_profile.profile_vault.name]
  image    = "ubuntu-minimal-noble-hashi"
}
