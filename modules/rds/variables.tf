variable "private_sn_ids" {
  type        = list(string)
  description = "list of private subnet ids"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "list of security group ids"
}

variable "db_sg_config" { # db subnet group config
  type = object({
    name        = string
    description = string
  })
  description = "obejct of subnet group config"
}

variable "db_pg_config" { # db parameter group config
  type = map(object({
    family      = string
    description = string
    parameter   = list(string)
  }))
  description = "list of object of db param group configs"
}

variable "db_instance_config" {
  type = list(object({
    allocated_storage                     = number
    allow_major_version_upgrade           = bool
    apply_immediately                     = bool
    auto_minor_version_upgrade            = bool
    backup_retention_period               = number
    blue_green_update                     = bool
    parameter_group_name                  = string
    db_name                               = string
    deletion_protection                   = bool
    enabled_cloudwatch_logs_exports       = list(string)
    engine                                = string
    engine_version                        = string
    identifier                            = string
    instance_class                        = string
    multi_az                              = bool
    username                              = string
    password                              = string
    performance_insights_enabled          = bool
    performance_insights_retention_period = number
    port                                  = number
    publicly_accessible                   = bool
    replica_mode                          = string
    storage_encrypted                     = bool
    timezone                              = string
  }))
  description = "list of object of db instance configs"
}
