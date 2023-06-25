resource "aws_s3_bucket" "bucket" {
  for_each = var.s3_config
  bucket   = each.key
  lifecycle {
    # prevent_destroy = each.value.prevent_destroy
    prevent_destroy = true
  }
  tags = {
    Name = each.key
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  for_each = var.s3_config
  bucket   = aws_s3_bucket.bucket[each.key].id
  versioning_configuration {
    status = each.value.versioning_status
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
  for_each = var.s3_config
  bucket   = aws_s3_bucket.bucket[each.key].id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = each.value.sse_algorithm
    }
  }
}
