variable "network_config" {
  type = object({
    vpc_cidr_range               = string
    public_subnet_cidrs          = list(string)
    private_subnet_data_cidrs    = list(string)
    private_subnet_compute_cidrs = list(string)
  })
}

variable "network_security_groups" {
  type = object({
    ssh_prefix_lists  = list(string)
    http_prefix_lists = list(string)
    data_prefix_lists = list(string)
  })
}

variable "network_components" {
  type = object({
    require_ecr_endpoint         = bool
    require_sqs_endpoint         = bool
    require_redshift_endpoint    = bool
    require_rds_endpoint         = bool
    require_nat_for_data_subnets = bool
  })
}

variable "infra_logging" {
  type = object({
    enable_vpc_flow_logs_cloudwatch = bool
  })
}

# Managed prefix lists -BEGIN-
variable "prefix_lists" {
  type = object({
    fb_internal_gw_prefixlist = list(string)
    fb_public_gw_prefixlist   = list(string)
    imperva_prefixlist        = list(string)
    egress_control_prefixlist = list(string)
  })
}





#do not use these variables.
#this data will be generated dynamically by the automation(python) scripts

# *** populate the below from account specific terraform_config.json
variable "fb_tfstate_region" { type = string }
variable "fb_primary_region" { type = string }
variable "fb_dr_region" { type = string }
variable "fb_secrets_region" { type = string }

# *** configs specific to account specific terraform workspace
variable "account_statefile_s3_bucket" { type = string }
variable "statefile_key" { type = string }
variable "account_workspace" { type = string }

# *** populated the below from *.tfvars.json ***
variable "fb_internal_gw_prefixlist" { type = list(string) }
variable "fb_public_gw_prefixlist" { type = list(string) }
variable "imperva_prefixlist" { type = list(string) }
variable "prefix_list_names" { type = list(string) }
variable "prefix_list_ids" { type = list(string) }

variable "egress_control_prefixlist" {
  type = list(string)
}
