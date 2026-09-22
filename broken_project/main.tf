terraform {
  required_version = ">= 1.2"
}

variable "example" {
  type        = string
  description = "Example input variable"
  default     = "value"
}

output "example" {
  value = var.example
}
