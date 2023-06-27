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


