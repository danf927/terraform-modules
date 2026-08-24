# Variable inputs for AWS VPC Terraform module

# Availability zone declaration - provide in a list of strings ["eu-west-2a", "eu-west-1b", etc.]
variable "azs" {
  description = "List of availability zones to spread subnets across"
  type        = list(string)
}

# VPC CIDR block - default is "10.0.0.0/16"
variable "cidr" {
  description = "CIDR block for the VPC - default 10.0.0.0/16"
  type        = string
  default     = "10.0.0.0/16"
}

# Boolean for enabling or disabling the NAT gateway on the VPC - default is enabled
variable "enable_nat_gateway" {
  description = "Boolean for enabling or disabling the NAT gateway on the VPC. Incurs an hourly cost while enabled."
  type        = bool
  default     = true
}

# Boolean for enabling or disabling the VPN gateway on the VPC - default is disabled
variable "enable_vpn_gateway" {
  description = "Boolean for enabling or disabling the VPN gateway on the VPC. Only needed for site-to-site VPN connectivity to on-prem/other networks."
  type        = bool
  default     = false
}

# Environment decalaration - used for tagging, declare Dev, Cert, or Prod.  Input validation will cause applys to fail if not provided corrctly
variable "environment" {
  description = "Environment string for tagging.  Set to Dev, Cert, or Prod"
  type        = string

  validation {
    condition     = contains(["Dev", "Cert", "Prod"], var.environment)
    error_message = "Environment must be Dev, Cert, or Prod."
  }
}

# VPC name
variable "name" {
  description = "The name of the VPC you are creating"
  type        = string
}

# Private subnets for internal traffic on the VPC - provide like ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
variable "private_subnets" {
  description = "Private subnets for internal traffic"
  type        = list(string)

  validation {
    condition     = length(var.private_subnets) == length(var.azs)
    error_message = "private_subnets must have the same number of entries as azs."
  }
}

# Public subnets for external traffic on the VPC - provide like ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
variable "public_subnets" {
  description = "Public subnets for external traffic"
  type        = list(string)

  validation {
    condition     = length(var.public_subnets) == length(var.azs)
    error_message = "public_subnets must have the same number of entries as azs."
  }
}

# Database subnets on the VPC - optional, provide like ["10.0.201.0/24", "10.0.202.0/24", "10.0.203.0/24"]. Leave empty to skip creating this tier.
variable "database_subnets" {
  description = "Database subnets for RDS/other data tier resources"
  type        = list(string)
  default     = []

  validation {
    condition     = length(var.database_subnets) == 0 || length(var.database_subnets) == length(var.azs)
    error_message = "database_subnets must be empty, or have the same number of entries as azs."
  }
}

# Elasticache subnets on the VPC - optional, provide like ["10.0.211.0/24", "10.0.212.0/24", "10.0.213.0/24"]. Leave empty to skip creating this tier.
variable "elasticache_subnets" {
  description = "Elasticache subnets for cache cluster resources"
  type        = list(string)
  default     = []

  validation {
    condition     = length(var.elasticache_subnets) == 0 || length(var.elasticache_subnets) == length(var.azs)
    error_message = "elasticache_subnets must be empty, or have the same number of entries as azs."
  }
}

# Redshift subnets on the VPC - optional, provide like ["10.0.221.0/24", "10.0.222.0/24", "10.0.223.0/24"]. Leave empty to skip creating this tier.
variable "redshift_subnets" {
  description = "Redshift subnets for data warehouse resources"
  type        = list(string)
  default     = []

  validation {
    condition     = length(var.redshift_subnets) == 0 || length(var.redshift_subnets) == length(var.azs)
    error_message = "redshift_subnets must be empty, or have the same number of entries as azs."
  }
}

# Additional tags to merge onto every resource this module creates, e.g. { Owner = "team-x", CostCenter = "1234" }
variable "tags" {
  description = "Additional tags to apply on top of this module's own fixed tags"
  type        = map(string)
  default     = {}
}
