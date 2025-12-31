locals {
  tags = {
    Owner       = var.owner
    Project     = "ecs"
    ManagedBy   = "terraform"
  }
}