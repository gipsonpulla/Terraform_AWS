variable "name" {
  type        = string
  description = "Name prefix."
}

variable "db_name" {
  type        = string
  description = "Initial database name."
}

variable "master_username" {
  type        = string
  description = "Master username."
}

variable "instance_class" {
  type        = string
  description = "RDS instance class."
}

variable "allocated_storage" {
  type        = number
  description = "Allocated storage in GiB."
}

variable "max_allocated_storage" {
  type        = number
  description = "Autoscaling storage upper limit in GiB."
}

variable "multi_az" {
  type        = bool
  description = "Whether DB is multi-AZ."
}

variable "backup_retention_period" {
  type        = number
  description = "Backup retention days."
}

variable "db_subnet_ids" {
  type        = list(string)
  description = "Subnet IDs for DB subnet group."
}

variable "db_security_group_id" {
  type        = string
  description = "DB security group ID."
}

variable "deletion_protection" {
  type        = bool
  description = "Enable RDS deletion protection."
  default     = true
}

variable "skip_final_snapshot" {
  type        = bool
  description = "Skip final snapshot on destroy."
  default     = true
}

variable "final_snapshot_identifier" {
  type        = string
  description = "Final snapshot identifier when skip_final_snapshot is false."
  default     = null
}

variable "engine_version" {
  type        = string
  description = "Postgres engine version."
  default     = "15.5"
}

variable "tags" {
  type        = map(string)
  description = "Common tags."
  default     = {}
}
