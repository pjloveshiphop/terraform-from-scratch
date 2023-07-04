variable "aws_account_id" {
  type        = string
  description = "aws account id which terraform resources deploy to"
}

variable "aws_region" {
  type        = string
  description = "aws region code which terraform resources deploy into"
}

variable "shared_config_file" {
  type        = string
  description = "aws config file path"

}

variable "shared_credentials_files" {
  type        = string
  description = "aws credentials file path"

}

variable "aws_config_profile" {
  type        = string
  description = "aws credentials profile"
}

variable "terraform_repo_name" {
  type        = string
  description = "terraform repository name"
}

variable "env" {
  type        = string
  description = "environment which terraform resources deploy into"
}

variable "maintainer" {
  type        = string
  description = "maintainer of terrafrom resources"
}

# variable "s3_config" {
#   type = map(object({
#     prevent_destroy   = bool
#     versioning_status = string
#     sse_algorithm     = string
#   }))

#   description = "map of s3 config object"
# }

# variable "dynamodb_table_nm" {
#   type        = string
#   description = "name of dynamodb table"
# }

variable "vpc_nm" {
  type        = string
  description = "name of vpc"
}
variable "vpc_cidr_block" {
  type        = string
  description = "cidr block of vpc"
}

variable "azs" {
  type        = list(string)
  description = "list of availability zones"
}

variable "public_sn_cidr_blocks" {
  type        = list(string)
  description = "list of public subnet cidr blocks"
}

variable "public_sn_nms" {
  type        = list(string)
  description = "list of public subnet names"
}

variable "private_sn_cidr_blocks" {
  type        = list(string)
  description = "list of private subnet cidr blocks"
}

variable "private_sn_nms" {
  type        = list(string)
  description = "list of private subnet names"
}
variable "eip_nms" {
  type        = list(string)
  description = "list of eip names"
}

variable "cgw_config" {
  type = list(object({
    name       = string
    ip_address = string
  }))
  description = "list of customer gateway device config objects"
}

variable "sg_config" {
  type = map(object({
    name        = string
    description = string
  }))
}

variable "sg_rule" {
  type = map(object({
    sg_nm                    = string
    type                     = string
    from_port                = number
    to_port                  = number
    protocol                 = string
    cidr_blocks              = list(string)
    prefix_list_ids          = list(string)
    self                     = bool
    source_security_group_id = string
    description              = string
  }))
}

variable "key_config" {
  type = list(object({
    key_nm          = string
    public_key_path = string
  }))
  description = "list of ec2 key configs"
}

variable "ec2_config" {
  type = list(object({
    instance_name               = string
    ami                         = string
    associate_public_ip_address = bool
    az                          = string
    instance_type               = string
    key_nm                      = string
    monitoring                  = bool
    root_block_device = object({
      delete_on_termination = bool
      encrypted             = bool
      iops                  = number
      volume_size           = number
      volume_type           = string
      root_name             = string
    })
  }))
}

variable "ebs_config" {
  type = list(object({
    az             = string
    encrypted      = bool
    final_snapshot = bool
    iops           = number
    size           = number
    type           = string
    vol_nm         = string
    device_nm      = string
    instance_id    = number
  }))
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

variable "iam_policy_config" {
  type = list(object({
    policy_nm   = string
    description = string
    policy_file = string
  }))
  description = "list of iam policy config objects"
}

variable "iam_group_config" {
  type        = list(string)
  description = "list of group names"
}

variable "iam_user_config" {
  type = map(object({
    employee_no = string
    team        = string
  }))
  description = "map of object for iam user configs"
}

variable "iam_user_create_access_key" {
  type        = list(string)
  description = "list of iam user name to create accessKey"
}
