data "aws_route53_zone" "hasangatus" {
  name         = "hasangatus.click"
  private_zone = false
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.hasangatus.zone_id
  name    = "tm.${data.aws_route53_zone.hasangatus.name}"
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = false
  }
}