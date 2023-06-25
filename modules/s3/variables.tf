variable "s3_config" {
  type = map(object({
    prevent_destroy   = bool
    versioning_status = string
    sse_algorithm     = string
  }))

  description = "map of s3 config object"
}
