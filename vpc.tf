#Define VPC
resource "aws_vpc" "main" {
  provider = aws.primary

  cidr_block           = var.network_config.vpc_cidr_range
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(local.common_tags, {
    Name = local.env
    team = "dev"
  })
}

#setup flow logs
module "vpc_flow_logs_cloudwatch" {
  source = "./../fb-modules/fb-flow-log"
  providers = {
    aws = aws.primary
  }
  count = var.infra_logging.enable_vpc_flow_logs_cloudwatch ? 1 : 0

  vpc_id     = aws_vpc.main.id
  subnet_ids = [] #tolist(aws_subnet.public_subnets.*.id)

  flow_log_destination_type              = "cloud-watch-logs"
  create_flow_log_cloudwatch_log_group   = true
  cloudwatch_log_group_name_prefix       = "/aws/vpc-flow-log/"
  cloudwatch_log_group_retention_in_days = 60
  cloudwatch_iam_role_arn                = local.global_resources.vpc_flow_log_cloudwatch_iam_role

  vpc_flow_log_tags = local.common_tags
}
