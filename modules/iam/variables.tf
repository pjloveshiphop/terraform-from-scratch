variable "iam_policy_config" {
  type = map(object({
    description = string
    policy_file = string
  }))
  description = "list of iam policy config objects"
}

variable "iam_group_config" {
  type = map(object({
    group_nm = string
  }))
  description = "list of group names"
}

variable "iam_group_member_config" {
  type = map(object({
    users           = list(string)
    target_group_nm = string
  }))
  description = "map of object for iam group membership config"
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

variable "iam_policy_attachment_config" {
  type = map(object({
    attachment_nm = string
    user_nm       = string
    role_nm       = string
    group_nm      = string
    policy_nm     = string
  }))
}

variable "iam_role_config" {
  type = list(object({
    assume_role_policy_file = string
    description             = string
    managed_policy_arns     = list(string)
    role_nm                 = string
    role_policy_nm          = string
    role_policy_file        = string
  }))

}