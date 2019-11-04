output "certificate_arn" {
  description = "The ARN of the certificate"
  value       = aws_acm_certificate.domain.arn
}

output "certificate_domain_validation_options" {
  description = "Validation options for the certificate"
  value       = aws_acm_certificate.domain.domain_validation_options
}

output "certificate_arn_regional" {
  description = "The ARN of the regional certificate"
  value       = aws_acm_certificate.domain_regional.arn
}

output "certificate_regional_validation_options" {
  description = "Validation options for the regional certificate"
  value       = aws_acm_certificate.domain_regional.domain_validation_options
}
