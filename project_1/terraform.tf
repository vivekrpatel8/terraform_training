# Reference: https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-create#the-terraform-block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.92"
    }
  }
  required_version = ">= 1.2"
}
