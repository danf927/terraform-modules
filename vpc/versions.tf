# Terraform and provider version constraints for AWS VPC module.

terraform {
  # Minimum Terraform CLI version this module supports - 1.9+ needed for cross-variable validation conditions
  required_version = ">= 1.9.0"

  required_providers {
    # AWS provider - pinned to major version 6 to avoid breaking changes
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
