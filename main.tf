terraform {
  required_version = ">= 0.12"
}

locals {
  tags = merge(
    {
      project     = var.project
      environment = var.environment
    },
    var.tags
  )
}

provider "aws" {
  region = "us-east-1"
  alias  = "cert-us-east-1"
}

resource "aws_acm_certificate" "domain" {
  domain_name               = var.domain
  subject_alternative_names = ["*.${var.domain}"]
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    local.tags,
    {
      "Name" = var.domain
    }
  )

  provider = aws.cert-us-east-1
}

resource "aws_route53_record" "domain_validation" {
  count = var.r53_hosted_zone_id != null ? 1 : 0

  zone_id         = var.r53_hosted_zone_id
  name            = lookup(aws_acm_certificate.domain.domain_validation_options[0], "resource_record_name")
  type            = lookup(aws_acm_certificate.domain.domain_validation_options[0], "resource_record_type")
  records         = [lookup(aws_acm_certificate.domain.domain_validation_options[0], "resource_record_value")]
  ttl             = "300"
  allow_overwrite = true
}

resource "aws_acm_certificate_validation" "domain_validation" {
  count = var.r53_hosted_zone_id != null ? 1 : 0

  certificate_arn         = aws_acm_certificate.domain.arn
  validation_record_fqdns = [aws_route53_record.domain_validation[0].fqdn]

  provider = aws.cert-us-east-1
}

resource "aws_acm_certificate" "domain_regional" {
  domain_name               = var.domain
  subject_alternative_names = ["*.${var.domain}"]
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    local.tags,
    {
      "Name" = var.domain
    }
  )
}

resource "aws_route53_record" "domain_validation_regional" {
  count = var.r53_hosted_zone_id != null ? 1 : 0

  zone_id         = var.r53_hosted_zone_id
  name            = lookup(aws_acm_certificate.domain_regional.domain_validation_options[0], "resource_record_name")
  type            = lookup(aws_acm_certificate.domain_regional.domain_validation_options[0], "resource_record_type")
  records         = [lookup(aws_acm_certificate.domain_regional.domain_validation_options[0], "resource_record_value")]
  ttl             = "300"
  allow_overwrite = true
}

resource "aws_acm_certificate_validation" "domain_validation_regional" {
  count = var.r53_hosted_zone_id != null ? 1 : 0

  certificate_arn         = aws_acm_certificate.domain_regional.arn
  validation_record_fqdns = [aws_route53_record.domain_validation_regional[0].fqdn]
}
