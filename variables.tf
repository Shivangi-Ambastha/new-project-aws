
variable "name" {
  type    = string
  default = ""
  validation {
    condition     = length(var.name) > 0
    error_message = "Role name can not be empty."
  }
}

variable "create_iam_instance_profile" {
  type    = bool
  default = false
}

variable "assume_role_policy" {
  type    = string
  default = ""

  validation {
    condition     = length(var.assume_role_policy) > 0
    error_message = "Assume role policy can not be empty."
  }
}

variable "policy_arns" {
  type    = list(string)
  default = []
}


variable "tags" { type = map(string) }
