# lxd_lab
LXD lab with TF, Packer, Incus, Ansible, Vault

# Bootstrap
First, need to install Ansible on the 'Virt host':
```bash
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```
Create the 'profile01' LXD profile that will add the proper SSH key to root's authorized_keys along with enabling the root account. Normally, I would cringe at this, but the fact that these are:
a) containers running Ubuntu-core
and
2) in a lab
... means I will overlook it.

```bash
echo "name: profile01
description: Baseline profile to include SSH keys for root
config:
  user.user-data: |
    #cloud-config
    disable_root: false
    disable_root_opts: ''
    ssh_authorized_keys:
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDgCFoYPrVE0KZK5wfbZqY9tZkexm/lqR316Od3jmjQ6bxsvLAthaDnrnDv9BRivGZB5ue+WPYIiaPZofe35/PT8Wv+kzg57/rvBVOVnY6eer9WtWzOmCCzScCgZtew3eTUlFgdqT4kjYN6dfL2iDqcrRbAUPSGjtvhTu2/2HUoAgQdpCNhaN9abScRCf8MQPCs2fvNeZ+cz7Ee3ORqlOwmyRuMLsuucDWGjb+A7x48/SpBgk6DMxJmidUb3XbZq8UD6Y0q6eO+mUYvDCP8YU9HschZuOI06RR5Zz/vgRvdv7eUpDZncCn1yOsdJ0TZBjydoA5Hu7yROyQi0y/0puKd
devices:
  eth0:
    name: eth0
    network: lxdbr0
    type: nic
  root:
    path: /
    pool: default
    type: disk
project: default" | lxc profile create profile01 -
```
