#Internet Gateway
resource "aws_internet_gateway" "igw" {
  provider = aws.primary

  vpc_id = aws_vpc.main.id

  tags = merge(local.common_tags, {
    Name = "${local.env}-igw"
  })
}

#NAT Gateway for Compute Subnets
module "natgw_compute" {
  source = "./../fb-modules/fb-nat-gateway"
  providers = {
    aws = aws.primary
  }

  subnet_id = aws_subnet.public_subnets[0].id
  tags = merge(local.common_tags, {
    Name = "${local.env}-nat-gw-compute"
  })
}

#NAT Gateway for Data Subnets
module "natgw_data" {
  source = "./../fb-modules/fb-nat-gateway"
  providers = {
    aws = aws.primary
  }

  count = var.network_components.require_nat_for_data_subnets ? 1 : 0

  subnet_id = aws_subnet.public_subnets[1].id
  tags = merge(local.common_tags, {
    Name = "${local.env}-nat-gw-data"
  })
}