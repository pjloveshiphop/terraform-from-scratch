resource "aws_iam_policy" "policy" {
  count  = length(var.iam_policy_config) > 0 ? length(var.iam_policy_config) : 0
  name   = var.iam_policy_config[count.index].policy_nm
  path   = "/"
  policy = file(var.iam_policy_config[count.index].policy_file)
}

resource "aws_iam_group" "group" {
  count = length(var.iam_group_config) > 0 ? length(var.iam_group_config) : 0
  name  = var.iam_group_config[count.index]
  path  = "/"
}

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
  user  = aws_iam_user.user[count.index].name
}
