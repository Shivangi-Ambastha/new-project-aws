
#Fetching available AZs -BEGIN-
data "aws_availability_zones" "azs" {
  state = "available"
} #Fetching available AZs -END-

data "terraform_remote_state" "global" {
  backend = "s3"
  config = {
    bucket = local.global_terraform_state_config.statefile_s3_bucket
    key    = local.global_terraform_state_config.statefile_key
    region = local.global_terraform_state_config.s3bucket_region
  }
}
