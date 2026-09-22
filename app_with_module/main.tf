terraform {
  required_version = ">= 1.2"
}

# Consumes a local child module. A change under modules/ should validate THIS
# root, not the child module in isolation (that is what the /modules/ stripping does).
module "network" {
  source = "./modules/network"
  cidr   = "10.0.0.0/16"
}

output "network_cidr" {
  value = module.network.cidr
}
