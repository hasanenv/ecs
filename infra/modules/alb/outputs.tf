output "alb_dns_name" {
  value = aws_lb.ecs_lb.dns_name
}

output "alb_zone_id" {
  value = aws_lb.ecs_lb.zone_id
}

output "alb_target_group_arn" {
  value = aws_lb_target_group.alb_target_group.arn
}