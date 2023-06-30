output "public_sn0_id" {
  value = aws_subnet.public[0].id
}

output "public_sn1_id" {
  value = aws_subnet.public[1].id
}

output "public_sn2_id" {
  value = aws_subnet.public[2].id
}

output "private_sn0_id" {
  value = aws_subnet.private[0].id
}

output "private_sn1_id" {
  value = aws_subnet.private[1].id
}

output "private_sn2_id" {
  value = aws_subnet.private[2].id
}

output "test_sg_id" {
  value = aws_security_group.sg["test-sg"].id
}

output "dataplatform_kr_prod_rds_sg_id" {
  value = aws_security_group.sg["dataplatform-kr-prod-rds-sg"].id
}