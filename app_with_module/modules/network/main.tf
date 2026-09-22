# Testing
variable "cidr" {
  type        = string
  description = "VPC CIDR block."
}

output "cidr" {
  value = var.cidr
}
