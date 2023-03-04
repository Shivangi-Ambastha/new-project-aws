locals {
  env                       = terraform.workspace
 # account_id = data.aws_caller_identity.current.account_id
  az_zones                  = data.aws_availability_zones.azs.names
  sg_egress_allow_all_cidrs = ["0.0.0.0/0"]

  #Terraform aws provider config
  provider_config = {
    tfstate_region = var.fb_tfstate_region
    primary_region = var.fb_primary_region
    dr_region      = var.fb_dr_region
    secrets_region = var.fb_secrets_region
  }

  #Global resources State File - S3
  global_terraform_state_config = {
    statefile_s3_bucket = var.account_statefile_s3_bucket
    statefile_key       = format("env:/%s/%s", var.account_workspace, var.statefile_key)
    s3bucket_region     = local.provider_config.tfstate_region
  }  

  global_resources = {
    kms_encryption_key_id            = data.terraform_remote_state.global.outputs.master_data.kms_encryption_key_id
    kms_encryption_key_arn           = data.terraform_remote_state.global.outputs.master_data.kms_encryption_key_arn
    vpc_flow_log_cloudwatch_iam_role = data.terraform_remote_state.global.outputs.master_data.vpc_flow_log_cloudwatch_iam_role
  }

  network_security_groups = {
    fb_gateway_ssh_nsg    = module.fb_gateway_ssh_nsg.id
    fb_gateway_http_nsg   = module.fb_gateway_http_nsg.id
    fb_gateway_data_nsg   = module.fb_gateway_data_nsg.id
    ecr_endpoint_nsg      = module.ecr_endpoint_nsg.id
    sqs_endpoint_nsg      = module.sqs_endpoint_nsg.id
    redshift_endpoint_nsg = module.redshift_endpoint_nsg.id
    ssh_prefix_lists      = var.network_security_groups.ssh_prefix_lists
    http_prefix_lists     = var.network_security_groups.http_prefix_lists
    data_prefix_lists     = var.network_security_groups.data_prefix_lists
  }

  master_data = {
    imperva_gws_cidrs     = var.imperva_prefixlist
    fb_internal_gws_cidrs = var.fb_internal_gw_prefixlist
    fb_public_gws_cidrs   = var.fb_public_gw_prefixlist
    fb_all_gws_cidrs      = distinct(concat(var.fb_internal_gw_prefixlist, var.fb_public_gw_prefixlist))
    mngd_prefix_list_ids  = zipmap(var.prefix_list_names, var.prefix_list_ids)
  }

  vpc_endpoints = {
    s3_endpoint = module.vpc_endpoint_s3.id
  }

  common_tags = {
    Environment = local.env
    Inspector   = "Yes"
  }
}
