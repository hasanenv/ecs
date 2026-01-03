resource "aws_ssm_parameter" "gatus_config" {
  name  = "/gatus/config"
  type  = "SecureString"
  value = file("${path.root}/config/config.yaml")

  tags = local.tags
}