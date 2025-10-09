# resource "lxd_profile" "app_win_ad" {
#   name = "app_win_ad"
#   config = {
#     "user.app" = "win_ad"
#   }
# }
# 
# resource "lxd_instance" "win_ad" {
#   name     = "win-ad"
#   type     = "virtual-machine"
#   profiles = concat(var.lxd_profiles, ["app_win_ad","windows"])
#   image    = "win2022-min"
# }
