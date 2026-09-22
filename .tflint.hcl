# tflint configuration. Plugins are downloaded by `tflint --init` in CI.
# https://github.com/terraform-linters/tflint/blob/master/docs/user-guide/config.md

config {
  # Lint modules called by a root as well? Kept false: the CI lints each changed
  # root, and child modules are linted when they are the changed root themselves.
  call_module_type = "local"
}

plugin "terraform" {
  enabled = true
  preset  = "recommended"
}

plugin "aws" {
  enabled = true
  version = "0.49.0"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

rule "terraform_naming_convention" {
  enabled = true
}

rule "terraform_documented_variables" {
  enabled = true
}

rule "terraform_required_version" {
  enabled = true
}

rule "terraform_required_providers" {
  enabled = true
}

rule "terraform_unused_declarations" {
  enabled = true
}

rule "terraform_comment_syntax" {
  enabled = true
}
