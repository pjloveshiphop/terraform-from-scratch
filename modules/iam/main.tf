resource "aws_iam_group" "group" {
  for_each = var.iam_group_config
  name     = each.value.group_nm
  path     = "/"
}

resource "aws_iam_group_membership" "group_membership" {
  for_each = var.iam_group_member_config
  name     = each.key
  users    = each.value.users
  group    = aws_iam_group.group[each.value.target_group_nm].name
}


resource "aws_iam_role" "role" {
  count               = length(var.iam_role_config) > 0 ? length(var.iam_role_config) : 0
  assume_role_policy  = file(var.iam_role_config[count.index].assume_role_policy_file)
  description         = var.iam_role_config[count.index].description
  managed_policy_arns = length(var.iam_role_config[count.index].managed_policy_arns) == 0 ? null : var.iam_role_config[count.index].managed_policy_arns
  name                = var.iam_role_config[count.index].role_nm
  path                = "/"
  tags = {
    Name = var.iam_role_config[count.index].role_nm
  }
}

resource "aws_iam_role_policy" "role_policy" {
  count  = length(var.iam_role_config) > 0 ? length(var.iam_role_config) : 0
  name   = var.iam_role_config[count.index].role_policy_nm
  policy = file(var.iam_role_config[count.index].role_policy_file)
  role   = aws_iam_role.role[count.index].id
}

# resource "aws_iam_role_policy_attachment" "role_attachment" {
#   count      = length(var.iam_role_config) > 0 ? length(var.iam_role_config) : 0
#   role       = aws_iam_role.role[count.index].id
#   policy_arn = aws_iam_role_policy.role_policy[count.index].name

# }

resource "aws_iam_user" "user" {
  for_each      = var.iam_user_config
  name          = each.key
  path          = "/"
  force_destroy = true
  tags = {
    Name       = each.key
    EmployeeNo = each.value.employee_no
    Team       = each.value.team
  }
}

resource "aws_iam_access_key" "access_key" {
  count = length(var.iam_user_create_access_key) > 0 ? length(var.iam_user_create_access_key) : 0
  user  = aws_iam_user.user[element(var.iam_user_create_access_key, count.index)].name
}

resource "aws_iam_policy_attachment" "attachment" {
  for_each   = var.iam_policy_attachment_config
  name       = each.value.attachment_nm
  users      = each.value.user_nm == "" ? null : [aws_iam_user.user[each.value.user_nm].name]
  roles      = each.value.role_nm == "" ? null : [aws_iam_user.user[each.value.role_nm].name]
  groups     = each.value.group_nm == "" ? null : [aws_iam_user.user[each.value.group_nm].name]
  policy_arn = aws_iam_policy.policy[each.value.policy_nm].arn
}

resource "aws_iam_policy" "policy" {
  for_each = var.iam_policy_config
  name     = each.key
  path     = "/"
  policy   = file(each.value.policy_file)
}