terraform {
  required_version = ">= 1.2"
}

variable "environment" {
  type        = string
  description = "Deployment environment name."
  default     = "staging"
}

locals {
  name_prefix = "atvenu-${var.environment}"
}

output "name_prefix" {
  value = local.name_prefix
}
