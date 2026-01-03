resource "aws_ssm_parameter" "gatus_config" {
  name = "/gatus/config"
  type = "SecureString"

  value = file("${path.root}/../app/gatus/config.yaml")

  tags = local.tags
}