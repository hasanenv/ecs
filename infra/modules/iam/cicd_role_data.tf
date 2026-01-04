data "aws_iam_role" "cicd" {
  name = var.cicd_role_name
}