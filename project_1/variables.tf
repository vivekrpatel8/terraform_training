variable "aws_region" {
  type        = string
  description = "AWS region for all resources"
  default     = "us-east-1"
}

variable "aws_access_key_id" {
  type        = string
  description = "AWS Access Key"
  sensitive   = true
}

variable "aws_secret_access_key" {
  type        = string
  description = "AWS Secret Key"
  sensitive   = true
}
