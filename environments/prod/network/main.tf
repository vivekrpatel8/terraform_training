terraform {
  required_version = ">= 1.2"
}

# Deeply nested root (no /modules/ in the path). Detection should resolve the
# root to this directory itself: environments/prod/network.
variable "vpc_cidr" {
  type        = string
  description = "Production VPC CIDR blocks"
  default     = "10.10.0.0/16"
}

output "vpc_cidr" {
  value = var.vpc_cidr
}
