terraform {
  required_providers {
    lxd = {
      source  = "terraform-lxd/lxd"
      version = "2.5.0"
    }
  }
  cloud {
    organization = "dkettman"
    workspaces {
      name = "lxd_lab"
    }
  }
}

resource "lxd_profile" "app_vault" {
  name = "app_vault"
  config = {
    "user.app" = "Vault"
  }
}

resource "lxd_instance" "vaults" {
  count = var.cnt_vault
  name  = format("vault%02d", count.index + 1)
  #  profiles = [data.lxd_profile.profile01.name, lxd_profile.profile_vault.name]
  profiles = concat(var.lxd_profiles, ["app_vault"])
  image    = "ubuntu-minimal-noble-hashi"
}
