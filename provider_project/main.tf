terraform {
  required_version = ">= 1.2"
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

# Uses a real provider to confirm `terraform init -backend=false` installs
# providers during validation (no cloud credentials needed).
resource "null_resource" "example" {
  triggers = {
    value = "static"
  }
}

output "id" {
  value = null_resource.example.id
}
