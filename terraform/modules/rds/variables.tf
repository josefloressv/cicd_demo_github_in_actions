# Network
variable "vpc_id" {
    description = "The VPC ID"
    type        = string
}

variable "vpc_cidr" {
    description = "The CIDR block for the VPC"
    type        = string
}

# RDS Instance
variable "identifier" {
    description = "The identifier for the RDS instance"
    type        = string
}

variable "engine_version" {
    description = "The engine version for the RDS instance"
    type        = string
}

variable "instance_class" {
    description = "The instance class for the RDS instance"
    type        = string
}
variable "db_name" {
    description = "The name of the database to create"
    type        = string
}

variable "username" {
    description = "The username for the RDS instance"
    type        = string
}

variable "password" {
    description = "The password for the RDS instance"
    type        = string
}

variable "allocated_storage" {
    description = "The allocated storage for the RDS instance"
    type        = number
}

variable "availability_zone" {
    description = "The availability zone for the RDS instance"
    type        = string
}

variable "backup_retention_period" {
    description = "The number of days to retain automated backups"
    type        = number
}

variable "backup_window" {
  description = "The daily time range during which automated backups are created"
  type        = string
}

variable "maintenance_window" {
  description = "The weekly time range during which system maintenance can occur"
  type        = string
}

variable "max_allocated_storage" {
    description = "The maximum allocated storage for the RDS instance"
    type        = number
}

variable "performance_insights_enabled" {
    description = "Whether Performance Insights is enabled"
    type        = bool
}

variable "performance_insights_retention_period" {
    description = "The number of days to retain Performance Insights data"
    type        = number
}

variable "tags" {
    description = "The tags for the RDS instance"
    type        = map(string)
}

# Subnet Group
variable "db_subnet_group_name" {
    description = "Name for the DB subnet group"
    type        = string
}

variable "db_subnet_ids" {
    description = "List of subnet IDs for the DB subnet group"
    type        = list(string)
}

# Parameter Group
variable "db_parameter_group_name" {
    description = "Name for the DB parameter group"
    type        = string
}


# Replica Instance configuration
variable "enable_replica" {
    description = "Whether to create a replica instance"
    type        = bool
    default     = false
}

variable "availability_zone_replica" {
    description = "The availability zone for the RDS replica instance"
    type        = string
    default = ""
}
