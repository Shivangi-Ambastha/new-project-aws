#TODO: revisit later for further refining.

#Review: count added for stg and prd, RTs modified accordingly.
# public subnets - Route
module "pub_subnets_route" {
  source = "./../fb-modules/fb-route-table"
  providers = {
    aws = aws.primary
  }

  vpc_id     = aws_vpc.main.id
  subnet_ids = tolist(aws_subnet.public_subnets.*.id)

  routes = [{
    cidr_block = "0.0.0.0/0"
    gateway_id = tostring(aws_internet_gateway.igw.id)
  }]

  tags = merge(local.common_tags, {
    Name = "${local.env}-igw-rt"
  })
}

# Private compute subnets - Route
module "private_compute_subnets_route" {
  source = "./../fb-modules/fb-route-table"
  providers = {
    aws = aws.primary
  }

  vpc_id     = aws_vpc.main.id
  subnet_ids = tolist(aws_subnet.private_subnets_compute.*.id)

  routes = [{
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = tostring(module.natgw_compute.id)
    #nat_gateway_id = tostring(aws_nat_gateway.natgw1.id)
  }]

  tags = merge(local.common_tags, {
    Name = "${local.env}-nat-compute-rt"
  })
}

# Private data subnets - Route
module "private_data_subnets_route" {
  source = "./../fb-modules/fb-route-table"
  providers = {
    aws = aws.primary
  }

  vpc_id     = aws_vpc.main.id
  subnet_ids = tolist(aws_subnet.private_subnets_data.*.id)

  routes = [{
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.network_components.require_nat_for_data_subnets ? module.natgw_data.id : module.natgw_compute.id
  }]

  tags = merge(local.common_tags, {
    Name = "${local.env}-nat-data-rt"
  })
}
