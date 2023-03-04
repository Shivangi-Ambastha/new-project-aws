#TODO : Modify prefix list to FB-Gateway and Imperva
#Review : Imperva Ips not required here, imperva should be whitelisted only to Public LB.

# Security group to allow SSH traffic
module "fb_gateway_ssh_nsg" {
  source = "./../fb-modules/fb-security-group"
  providers = {
    aws = aws.primary
  }

  name                 = "${local.env}-fb-gw-ssh-nsg"
  description          = "Security group to allow SSH"
  vpc_id               = aws_vpc.main.id
  mngd_prefix_list_ids = local.master_data.mngd_prefix_list_ids
  inbound_rules = [
    {
      "protocol" : "tcp",
      "ports" : ["22"],
      "prefix_lists" : var.network_security_groups.ssh_prefix_lists,
      "cidr_blocks" : []
      "security_groups" : []
    }
  ]

  tags = merge(local.common_tags, {
    Name        = "${local.env}-fb-gw-ssh-nsg"
    Application = "network"
  })

}

# Security group to allow HTTP traffic
module "fb_gateway_http_nsg" {
  source = "./../fb-modules/fb-security-group"
  providers = {
    aws = aws.primary
  }

  name                 = "${local.env}-fb-gw-http-nsg"
  description          = "Security group to allow HTTP"
  vpc_id               = aws_vpc.main.id
  mngd_prefix_list_ids = local.master_data.mngd_prefix_list_ids
  inbound_rules = [
    {
      "protocol" : "tcp",
      "ports" : ["443"],
      "prefix_lists" : var.network_security_groups.http_prefix_lists,
      "cidr_blocks" : []
      "security_groups" : []
    }
  ]

  tags = merge(local.common_tags, {
    Name        = "${local.env}-fb-gw-http-nsg"
    Application = "network"
  })

}

# Security group to allow DATA traffic
module "fb_gateway_data_nsg" {
  source = "./../fb-modules/fb-security-group"
  providers = {
    aws = aws.primary
  }

  name                 = "${local.env}-fb-gw-data-nsg"
  description          = "Security group to allow traffic to DATA resources"
  vpc_id               = aws_vpc.main.id
  mngd_prefix_list_ids = local.master_data.mngd_prefix_list_ids
  inbound_rules = [
    {
      "protocol" : "-1",
      "ports" : ["0"],
      "prefix_lists" : var.network_security_groups.data_prefix_lists,
      "cidr_blocks" : []
      "security_groups" : []
    }
  ]

  tags = merge(local.common_tags, {
    Name        = "${local.env}-fb-gw-data-nsg"
    Application = "network"
  })

}