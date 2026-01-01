resource "aws_acm_certificate" "alb_cert" {
  domain_name               = var.domain_name
  subject_alternative_names = ["tm.${var.domain_name}"]
  validation_method         = "DNS"

  tags = local.tags
}

resource "aws_route53_record" "acm_certificate_validation" {
  for_each = {
    for dvo in aws_acm_certificate.alb_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = var.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 60
  records = [each.value.record]
}

resource "aws_acm_certificate_validation" "alb_cert_validation" {
  certificate_arn         = aws_acm_certificate.alb_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.acm_certificate_validation : record.fqdn]
}