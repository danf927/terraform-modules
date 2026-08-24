# vpc

A reusable module for standing up an AWS VPC with public/private subnets, and optional database/elasticache/redshift subnet tiers.

## Requirements

- Terraform `>= 1.9.0` (cross-variable validation on subnet counts requires 1.9+)
- AWS provider `~> 6.0`

## Usage

```hcl
module "vpc" {
  source = "../vpc" # or a git ref once this repo is tagged/versioned

  name        = "app-dev"
  environment = "Dev"

  cidr = "10.0.0.0/16"
  azs  = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]

  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  tags = {
    Owner      = "platform-team"
    CostCenter = "1234"
  }
}
```

`database_subnets`, `elasticache_subnets`, and `redshift_subnets` are optional — omit them (or leave as `[]`) to skip creating that tier entirely.

## Design notes

- `azs`, `private_subnets`, and `public_subnets` have **no default** — a caller who forgets to set them gets a hard error at `plan` time instead of silently deploying into the wrong region/topology.
- `private_subnets`, `public_subnets`, `database_subnets`, `elasticache_subnets`, and `redshift_subnets` are each validated to have the same number of entries as `azs` (or be empty, for the optional tiers).
- `environment` is restricted to `Dev`, `Cert`, or `Prod` via a `validation` block.
- `tags` are merged on top of this module's own fixed tags (`Terraform`, `Environment`) — pass additional tags like `Owner` or `CostCenter` without needing to fork the module.
- `enable_nat_gateway` defaults to `true` (most VPCs with private subnets need outbound internet access); `enable_vpn_gateway` defaults to `false` (site-to-site VPN is a niche need, not every VPC's default).

## AI Disclosure

This module was built with the assistance of generative AI (Claude Code).  AI was used for the following:
- Best-practice/12-Factor-App compliance validation.
- Drafting of technical documentation
- Creation of .gitignore files

## Inputs

| Name | Description | Type | Default | Required |
|---|---|---|---|---|
| `name` | Name of the VPC you are creating | `string` | n/a | yes |
| `cidr` | CIDR block for the VPC | `string` | `"10.0.0.0/16"` | no |
| `azs` | Availability zones to spread subnets across | `list(string)` | n/a | yes |
| `private_subnets` | Private subnet CIDRs (must match `azs` count) | `list(string)` | n/a | yes |
| `public_subnets` | Public subnet CIDRs (must match `azs` count) | `list(string)` | n/a | yes |
| `database_subnets` | Database subnet CIDRs (must match `azs` count, or be empty) | `list(string)` | `[]` | no |
| `elasticache_subnets` | Elasticache subnet CIDRs (must match `azs` count, or be empty) | `list(string)` | `[]` | no |
| `redshift_subnets` | Redshift subnet CIDRs (must match `azs` count, or be empty) | `list(string)` | `[]` | no |
| `enable_nat_gateway` | Enable/disable the NAT gateway. Incurs an hourly cost while enabled | `bool` | `true` | no |
| `enable_vpn_gateway` | Enable/disable the VPN gateway. Only needed for site-to-site VPN | `bool` | `false` | no |
| `environment` | Environment tag - must be `Dev`, `Cert`, or `Prod` | `string` | n/a | yes |
| `tags` | Additional tags merged on top of this module's own fixed tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|---|---|
| `vpc_id` | ID of the VPC |
| `vpc_name` | Name of the VPC |
| `vpc_cidr_block` | CIDR block of the VPC |
| `private_subnets` | IDs of the private subnets |
| `public_subnets` | IDs of the public subnets |
| `database_subnets` | IDs of the database subnets |
| `elasticache_subnets` | IDs of the elasticache subnets |
| `redshift_subnets` | IDs of the redshift subnets |
| `igw_id` | ID of the Internet Gateway |
| `natgw_ids` | IDs of the NAT Gateway(s) |
| `vgw_id` | ID of the VPN Gateway |
