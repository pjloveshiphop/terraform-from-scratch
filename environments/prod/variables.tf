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

variable "s3_config" {
  type = map(object({
    prevent_destroy   = bool
    versioning_status = string
    sse_algorithm     = string
  }))

  description = "map of s3 config object"
}

variable "dynamodb_table_nm" {
  type        = string
  description = "name of dynamodb table"
}

variable "vpc_config" {
  type = map(object({
    cidr_block           = string
    instance_tenancy     = string # default | dedicated
    enable_dns_support   = bool   #true | false
    enable_dns_hostnames = bool   #true | false
  }))
}
