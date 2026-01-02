# -------------------------
# Network
# -------------------------
variable "vpc_cidr" {
  type    = string
}

variable "public_subnet_cidrs" {
  type    = list(string)
}

variable "private_subnet_cidrs" {
  type    = list(string)
}

# -------------------------
# Environment / policy
# -------------------------
variable "aws_region" {
  type    = string
}

variable "availability_zones" {
  type    = list(string)
}

variable "owner" {
  type    = string
}

# -------------------------
# Deployment
# -------------------------
variable "image_tag" {
  type        = string
  description = "Docker image tag for ECS task definition"
}