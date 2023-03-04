terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.20.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.0.0"
    }
  }

  backend "s3" {

  }
}



provider "aws" {
  region = local.provider_config.primary_region
}

provider "aws" {
  alias  = "primary"
  region = local.provider_config.primary_region
}

provider "aws" {
  alias  = "secrets"
  region = local.provider_config.secrets_region
}

provider "null" {
}