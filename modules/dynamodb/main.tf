resource "aws_dynamodb_table" "table" {
  name         = var.dynamodb_table_nm
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
