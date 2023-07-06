output "eks_cluster_role" {
  value = aws_iam_role.role[1].arn
}

output "eks_ng_role" {
  value = aws_iam_role.role[2].arn
}