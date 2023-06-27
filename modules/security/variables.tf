variable "vpc_id" {
  type        = string
  description = "id of vpc"
}

variable "sg_config" {
  type = map(object({
    description = string
  }))
}
