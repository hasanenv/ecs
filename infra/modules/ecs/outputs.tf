output "cluster_name" {
  value = aws_ecs_cluster.gatus_cluster.name
}

output "service_name" {
  value = aws_ecs_service.gatus_service.name
}
