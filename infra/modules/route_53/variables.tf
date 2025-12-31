variable "zone_id" {
    description = "The Route53 hosted zone id"
    type        = string
}

variable "zone_name" {
    description = "The Route53 hosted zone name"
    type        = string
}

variable "alb_dns_name" {
    description = "The DNS name of the ALB to create the Route 53 record for."
    type        = string
}

variable "alb_zone_id" {
    description = "The hosted zone ID of the ALB to create the Route 53 record for."
    type        = string
}