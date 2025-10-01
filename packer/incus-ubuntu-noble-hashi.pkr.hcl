packer {
  required_plugins {
    incus = {
      source  = "github.com/bketelsen/incus"
      version = "~> 1"
    }
    ansible = {
      version = "~> 1"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

source "incus" "incus-ubuntu-noble-cloud" {
  image        = "images:ubuntu/noble/cloud"
  output_image = "ubuntu-noble-cloud-hashi-${formatdate("YYYYMMDDhhmmss", timestamp())}"
  # output_image = "ubuntu-minimal-noble-hashi"
  profile = "profile01"
  publish_properties = {
    description = "Ubuntu Noble Cloud - HashiCorp"
  }
}

build {
  name = "incus-ubuntu-minimal-noble-hashi"
  sources = [
    "source.incus.incus-ubuntu-noble-cloud"
  ]

  #  provisioner "ansible" {
  #  user                    = "root"
  #  ansible_env_vars        = ["ANSIBLE_HOST_KEY_CHECKING=false", "ANSIBLE_USER=root"]
  #  ssh_authorized_key_file = "/home/ubuntu/.ssh/authorized_keys"
  #  playbook_file           = "./playbook.yml"
  #  inventory_file          = "./inventory.incus.yaml"
  #}

  post-processors {
    post-processor "shell-local" {
      inline = [
        "incus image alias delete ubuntu-noble-cloud-hashi || true",
        "incus image alias create ubuntu-noble-cloud-hashi $(incus image list -c f --format csv | head -n1)"
      ]
    }
  }
}
