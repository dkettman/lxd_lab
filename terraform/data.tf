data "lxd_network" "lxdbr0" {
  name = "lxdbr0"
}

data "lxd_storage_pool" "data01" {
  name = var.lxd_storage_pool
}
