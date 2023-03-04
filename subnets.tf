#Creates public subnets
resource "aws_subnet" "public_subnets" {
  count    = length(var.network_config.public_subnet_cidrs)
  provider = aws.primary

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.network_config.public_subnet_cidrs[count.index]
  availability_zone = local.az_zones[count.index]

  tags = merge(local.common_tags, {
    Name = "${local.env}-public-subnet-${local.az_zones[count.index]}"
  })
}

#Creates compute private subnets
resource "aws_subnet" "private_subnets_compute" {
  count    = length(var.network_config.private_subnet_compute_cidrs)
  provider = aws.primary

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.network_config.private_subnet_compute_cidrs[count.index]
  availability_zone = local.az_zones[count.index]

  tags = merge(local.common_tags, {
    Name = "${local.env}-private-subnet-compute-${local.az_zones[count.index]}"
  })
}

#Creates data private subnets
resource "aws_subnet" "private_subnets_data" {
  count    = length(var.network_config.private_subnet_data_cidrs)
  provider = aws.primary

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.network_config.private_subnet_data_cidrs[count.index]
  availability_zone = local.az_zones[count.index]

  tags = merge(local.common_tags, {
    Name = "${local.env}-private-subnet-data-${local.az_zones[count.index]}"
  })
}
