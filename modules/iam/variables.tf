variable "iam_policy_config" {
  type = list(object({
    policy_nm   = string
    description = string
    policy_file      = string
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
