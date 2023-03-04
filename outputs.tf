output "vpc_id" {
  value = aws_vpc.main.id
}

output "vpc_cidr" {
  value = var.network_config.vpc_cidr_range
}

output "public_subnets" {
  value = tolist(aws_subnet.public_subnets.*.id)
}

output "private_compute_subnets" {
  value = tolist(aws_subnet.private_subnets_compute.*.id)
}

output "private_data_subnets" {
  value = tolist(aws_subnet.private_subnets_data.*.id)
}

output "network_security_groups" {
  value = local.network_security_groups
}

output "vpc_endpoints" {
  value = local.vpc_endpoints
}

output "master_data" {
  value     = local.master_data
  sensitive = true
}