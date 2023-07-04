variable "vpc_nm" {
  type        = string
  description = "name of vpc"
}
variable "vpc_cidr_block" {
  type        = string
  description = "cidr block of vpc"
}

variable "azs" {
  type        = list(string)
  description = "list of availability zones"
}

variable "public_sn_cidr_blocks" {
  type        = list(string)
  description = "list of public subnet cidr blocks"
}

variable "public_sn_nms" {
  type        = list(string)
  description = "list of public subnet names"
}

variable "private_sn_cidr_blocks" {
  type        = list(string)
  description = "list of private subnet cidr blocks"
}

variable "private_sn_nms" {
  type        = list(string)
  description = "list of private subnet names"
}

variable "eip_nms" {
  type = list(string)
  description = "list of eip names"
}

variable "cgw_config" {
  type = list(object({
    name       = string
    ip_address = string
  }))
  description = "list of customer gateway device config objects"
}

variable "sg_config" {
  type = map(object({
    name        = string
    description = string
  }))
}

variable "sg_rule" {
  type = map(object({
    sg_nm                    = string
    type                     = string
    from_port                = number
    to_port                  = number
    protocol                 = string
    cidr_blocks              = list(string)
    prefix_list_ids          = list(string)
    self                     = bool
    source_security_group_id = string
    description              = string
  }))
}
