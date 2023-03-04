# s3 endpoint
module "vpc_endpoint_s3" {
  source = "./../fb-modules/fb-vpc-endpoint"
  providers = {
    aws = aws.primary
  }

  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${local.provider_config.primary_region}.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    module.pub_subnets_route.routet_table_id,
    module.private_compute_subnets_route.routet_table_id,
    module.private_data_subnets_route.routet_table_id
  ]

  tags = merge(local.common_tags, {
    Name = "${local.env}-s3-endpoint"
  })
}

#ecr docker - interface
module "vpc_endpoint_ecr_docker" {
  source = "./../fb-modules/fb-vpc-endpoint"
  providers = {
    aws = aws.primary
  }

  count             = var.network_components.require_ecr_endpoint ? 1 : 0
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${local.provider_config.primary_region}.ecr.dkr"
  vpc_endpoint_type = "Interface"
  security_group_ids = [
    module.ecr_endpoint_nsg.id
  ]
  subnet_ids = tolist(aws_subnet.private_subnets_compute.*.id)

  depends_on = [
    module.ecs_longarn_setting,
  ]

  tags = merge(local.common_tags, {
    Name = "${local.env}-ecr-docker-endpoint"
  })
}

# ecr api - interface
module "vpc_endpoint_ecr_api" {
  source = "./../fb-modules/fb-vpc-endpoint"
  providers = {
    aws = aws.primary
  }

  count             = var.network_components.require_ecr_endpoint ? 1 : 0
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${local.provider_config.primary_region}.ecr.api"
  vpc_endpoint_type = "Interface"
  security_group_ids = [
    module.ecr_endpoint_nsg.id
  ]
  subnet_ids = tolist(aws_subnet.private_subnets_compute.*.id)

  depends_on = [
    module.ecs_longarn_setting,
  ]

  tags = merge(local.common_tags, {
    Name = "${local.env}-ecr-api-endpoint"
  })
}

# sqs interface
module "vpc_endpoint_sqs" {
  source = "./../fb-modules/fb-vpc-endpoint"
  providers = {
    aws = aws.primary
  }

  count             = var.network_components.require_sqs_endpoint ? 1 : 0
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${local.provider_config.primary_region}.sqs"
  vpc_endpoint_type = "Interface"
  security_group_ids = [
    module.sqs_endpoint_nsg.id
  ]
  subnet_ids = tolist(aws_subnet.private_subnets_compute.*.id)

  tags = merge(local.common_tags, {
    Name = "${local.env}-sqs-endpoint"
  })
}


module "vpc_endpoint_redshift" {
  source = "./../fb-modules/fb-vpc-endpoint"
  providers = {
    aws = aws.primary
  }

  count             = var.network_components.require_redshift_endpoint ? 1 : 0
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${local.provider_config.primary_region}.redshift"
  vpc_endpoint_type = "Interface"
  security_group_ids = [
    module.redshift_endpoint_nsg.id
  ]
  subnet_ids = tolist(aws_subnet.private_subnets_compute.*.id)

  tags = merge(local.common_tags, {
    Name = "${local.env}-redshift-endpoint"
  })
}

module "vpc_endpoint_rds" {
  source = "./../fb-modules/fb-vpc-endpoint"
  providers = {
    aws = aws.primary
  }

  count             = var.network_components.require_rds_endpoint ? 1 : 0
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${local.provider_config.primary_region}.rds"
  vpc_endpoint_type = "Interface"
  security_group_ids = [
    module.rds_endpoint_nsg.id
  ]
  subnet_ids = tolist(aws_subnet.private_subnets_compute.*.id)

  tags = merge(local.common_tags, {
    Name = "${local.env}-rds-endpoint"
  })
}
