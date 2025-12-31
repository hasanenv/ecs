variable "vpc_cidr" {
  type = string
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "aws_region" {
  type = string
}
variable "owner" {
  type = string
}

variable "availability_zones" {
  type = list(string)
}
