# -------------------------
# Network (explicit inputs)
# -------------------------
variable "vpc_cidr" {
  type = string
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

# -------------------------
# Environment / policy
# -------------------------
variable "aws_region" {
  type    = string
  default = "eu-west-2"
}

variable "availability_zones" {
  type    = list(string)
  default = ["eu-west-2a", "eu-west-2b"]
}

variable "owner" {
  type    = string
  default = "hasan"
}

# -------------------------
# Deployment
# -------------------------
variable "image_tag" {
  type        = string
  description = "Docker image tag for ECS task definition"
}
