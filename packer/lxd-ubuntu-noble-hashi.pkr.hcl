packer {
  required_plugins {
    lxd = {
      source  = "github.com/hashicorp/lxd"
      version = "~>1"
    }
    ansible = {
      version = "~> 1"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

source "lxd" "lxd-ubuntu-minimal-noble" {
  image        = "ubuntu-minimal:noble"
  output_image = "ubuntu-minimal-noble-hashi-${formatdate("YYYYMMDDhhmmss", timestamp())}"
  # output_image = "ubuntu-minimal-noble-hashi"
  profile = "profile01"
  publish_properties = {
    description = "Ubuntu-Minimal Noble - HashiCorp"
  }
}

build {
  name = "lxd-ubuntu-minimal-noble-hashi"
  sources = [
    "source.lxd.lxd-ubuntu-minimal-noble"
  ]

  provisioner "ansible" {
    user                    = "root"
    ansible_env_vars        = ["ANSIBLE_HOST_KEY_CHECKING=false", "ANSIBLE_USER=root"]
    ssh_authorized_key_file = "/home/ubuntu/.ssh/authorized_keys"
    playbook_file           = "./playbook.yml"
    inventory_file          = "./inventory.lxd.yaml"
  }

  post-processors {
    post-processor "shell-local" {
      inline = [
        "lxc image alias delete ubuntu-minimal-noble-hashi || true",
        "lxc image alias create ubuntu-minimal-noble-hashi $(lxc image list -c f --format csv | head -n1)"
      ]
    }
  }
}
