variable "cicd_role_name" {
  description = "Existing CI/CD IAM role name assumed via OIDC (created outside via console)."
  type        = string
}

variable "owner" {
  type = string
}