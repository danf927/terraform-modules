# Outputs file for AWS VPC module.

# Database subnets
output "database_subnets" {
  description = "Database subnets associated with the VPC"
  value       = module.vpc.database_subnets
}

# Elasticache subnets
output "elasticache_subnets" {
  description = "Elasticache subnets associated with the VPC"
  value       = module.vpc.elasticache_subnets
}

# Internet Gateway ID
output "igw_id" {
  description = "Internet Gateway ID associated with the VPC"
  value       = module.vpc.igw_id
}

# Nat Gateway ID
output "natgw_ids" {
  description = "NAT Gateway ID(s) associated with the VPC"
  value       = module.vpc.natgw_ids
}

# Private subnets
output "private_subnets" {
  description = "Private subnets associated with the VPC"
  value       = module.vpc.private_subnets
}

# Public subnets
output "public_subnets" {
  description = "Public subnets associated with the VPC"
  value       = module.vpc.public_subnets
}

# Redshift subnets
output "redshift_subnets" {
  description = "Redshift subnets associated with the VPC"
  value       = module.vpc.redshift_subnets
}

# VPN Gateway ID
output "vgw_id" {
  description = "VPN gateway ID associated with the VPC"
  value       = module.vpc.vgw_id
}

# VPC CIDR block
output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

# VPC ID
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

# VPC name
output "vpc_name" {
  description = "The name of the VPC"
  value       = module.vpc.name
}
