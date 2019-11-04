
terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region = var.region
}

resource "random_string" "suffix" {
  length  = 8
  special = false
  number  = false
}

locals {
  environment = lower("${var.environment}-${random_string.suffix.result}")
  main_domain = "example.com"
  sub_domain  = "example-${lower(random_string.suffix.result)}.${local.main_domain}"

  tags = {
    example = "true"
  }
}

# data "aws_route53_zone" "domain" {
#   name = local.main_domain
# }

# resource "aws_route53_record" "sub_domain" {
#   zone_id = data.aws_route53_zone.domain.zone_id
#   name    = local.sub_domain
#   type    = "A"

#   alias {
#     name                   = local.main_domain
#     zone_id                = data.aws_route53_zone.domain.zone_id
#     evaluate_target_health = true
#   }
# }

module "acm" {
  source = "../.."

  environment = local.environment
  project     = var.project

  domain = local.sub_domain

  # r53_hosted_zone_id = data.aws_route53_zone.domain.zone_id
}
