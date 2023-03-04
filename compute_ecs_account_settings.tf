# set ECT account settings for Long ARN format
module "ecs_longarn_setting" {
  source = "./../fb-modules/fb-ecs-prerequisite"
  providers = {
    aws = aws.primary
  }

  region = local.provider_config.primary_region
}