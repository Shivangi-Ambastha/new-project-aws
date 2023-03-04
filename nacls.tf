module "public_subnets_nacl" {
  source = "./../fb-modules/fb-nacl"
  providers = {
    aws = aws.primary
  }

  vpc_id     = aws_vpc.main.id
  subnet_ids = tolist(aws_subnet.public_subnets.*.id)

  tags = merge(local.common_tags, {
    Name = "${local.env}-pub-nacl"
  })
}

module "private_subnets_nacl_compute" {
  source = "./../fb-modules/fb-nacl"
  providers = {
    aws = aws.primary
  }

  vpc_id     = aws_vpc.main.id
  subnet_ids = tolist(aws_subnet.private_subnets_compute.*.id)

  tags = merge(local.common_tags, {
    Name = "${local.env}-pri-nacl-compute"
  })
}

module "private_subnets_nacl_data" {
  source = "./../fb-modules/fb-nacl"
  providers = {
    aws = aws.primary
  }

  vpc_id     = aws_vpc.main.id
  subnet_ids = tolist(aws_subnet.private_subnets_data.*.id)

  tags = merge(local.common_tags, {
    Name = "${local.env}-pri-nacl-data"
  })
}
