terraform {
  required_version = ">= 1.2"
}

# INTENTIONALLY BROKEN fixture: references an input variable that is never
# declared, so `terraform validate` fails. Used to confirm the workflow reports
# a failing root, and that fail-fast: false keeps other roots running.
output "broken" {
  value = var.does_not_exist
}
