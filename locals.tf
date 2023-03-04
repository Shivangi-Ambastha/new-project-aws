
#locals
locals {
  env             = terraform.workspace
  require_keypair = (length(var.keypair_name) == 0) ? false : true
}
