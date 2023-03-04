# ECR security group
module "ecr_endpoint_nsg" {
  source = "./../fb-modules/fb-security-group"
  providers = {
    aws = aws.primary
  }

  name                 = "${local.env}-ecr-ept-nsg"
  description          = "Security group to allow traffic to ECR"
  vpc_id               = aws_vpc.main.id
  mngd_prefix_list_ids = local.master_data.mngd_prefix_list_ids
  inbound_rules = [
    {
      "protocol" : "-1",
      "ports" : ["0"],
      "prefix_lists" : var.network_security_groups.ssh_prefix_lists,
      "cidr_blocks" : var.network_config.private_subnet_compute_cidrs
      "security_groups" : []
    }
  ]

  tags = merge(local.common_tags, {
    Name        = "${local.env}-ecr-ept-nsg"
    Application = "network"
  })
}

# ECR security group
module "sqs_endpoint_nsg" {
  source = "./../fb-modules/fb-security-group"
  providers = {
    aws = aws.primary
  }

  name                 = "${local.env}-sqs-ept-nsg"
  description          = "Security group to allow traffic to SQS"
  vpc_id               = aws_vpc.main.id
  mngd_prefix_list_ids = local.master_data.mngd_prefix_list_ids
  inbound_rules = [
    {
      "protocol" : "-1",
      "ports" : ["0"],
      "prefix_lists" : var.network_security_groups.ssh_prefix_lists,
      "cidr_blocks" : var.network_config.private_subnet_compute_cidrs
      "security_groups" : []
    }
  ]

  tags = merge(local.common_tags, {
    Name        = "${local.env}-sqs-ept-nsg"
    Application = "network"
  })
}

# Redshift security group
module "redshift_endpoint_nsg" {
  source = "./../fb-modules/fb-security-group"
  providers = {
    aws = aws.primary
  }

  name                 = "${local.env}-rsh-ept-nsg"
  description          = "Security group to allow traffic to Redshift"
  vpc_id               = aws_vpc.main.id
  mngd_prefix_list_ids = local.master_data.mngd_prefix_list_ids
  inbound_rules = [
    {
      "protocol" : "-1",
      "ports" : ["0"],
      "prefix_lists" : var.network_security_groups.ssh_prefix_lists,
      "cidr_blocks" : var.network_config.private_subnet_compute_cidrs
      "security_groups" : []
    }
  ]

  tags = merge(local.common_tags, {
    Name        = "${local.env}-rsh-ept-nsg"
    Application = "network"
  })
}

# RDS endpoint security group
module "rds_endpoint_nsg" {
  source = "./../fb-modules/fb-security-group"
  providers = {
    aws = aws.primary
  }

  name                 = "${local.env}-rds-ept-nsg"
  description          = "Security group to allow traffic to RDS"
  vpc_id               = aws_vpc.main.id
  mngd_prefix_list_ids = local.master_data.mngd_prefix_list_ids
  inbound_rules = [
    {
      "protocol" : "-1",
      "ports" : ["0"],
      "prefix_lists" : var.network_security_groups.ssh_prefix_lists,
      "cidr_blocks" : var.network_config.private_subnet_compute_cidrs
      "security_groups" : []
    }
  ]

  tags = merge(local.common_tags, {
    Name        = "${local.env}-rds-ept-nsg"
    Application = "network"
  })
}