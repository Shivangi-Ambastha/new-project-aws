# VPC Id
variable "vpc_id" {
  type    = string
  default = ""
  validation {
    condition     = length(var.vpc_id) > 0
    error_message = "VPC id can not be empty."
  }
}

#service name
variable "service_name" {
  type    = string
  default = ""
  validation {
    condition     = length(var.service_name) > 0
    error_message = "Service name can not be empty."
  }
}

# Endpoint type can be Gateway or Interface
variable "vpc_endpoint_type" {
  type    = string
  default = ""
  validation {
    condition     = length(var.vpc_endpoint_type) > 0
    error_message = "Endpoint type can not be empty."
  }
}

#route table ids
variable "route_table_ids" {
  type    = list(string)
  default = []
}

#subnet IDs
variable "subnet_ids" {
  type    = list(string)
  default = []
}

#security group IDs
variable "security_group_ids" {
  type    = list(string)
  default = []
}

variable "tags" { type = map(string) }
