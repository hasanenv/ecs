output "certificate_arn" {
  description = "ARN of ACM certificate"
  value       = aws_acm_certificate.alb_cert.arn
}

output "certificate_domain_name" {
  description = "Domain name of ACM certificate"
  value       = aws_acm_certificate.alb_cert.domain_name
}

output "certificate_status" {
  description = "Status of ACM certificate"
  value       = aws_acm_certificate.alb_cert.status
}