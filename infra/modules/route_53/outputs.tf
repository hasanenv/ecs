output "zone_id" {
    description = "The ID of the Route 53 hosted zone."
    value       = data.aws_route53_zone.hasangatus.zone_id
}

output "domain_name" {
    description = "The domain name of the Route 53 hosted zone."
    value       = data.aws_route53_zone.hasangatus.name
}