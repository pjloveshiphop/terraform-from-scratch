output "ec2_key_pair_test" {
  value = aws_key_pair.key[0].id
}