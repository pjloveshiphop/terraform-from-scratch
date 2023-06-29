variable "key_config" {
  type = list(object({
    key_nm          = string
    public_key_path = string
  }))
  description = "list of ec2 key configs"
}

variable "sn_id" {
  type        = string
  description = "id of public or private subnet"
}

variable "sg_id" {
  type        = list(string)
  description = "list of security group id(s)"
}

variable "ec2_config" {
  type = list(object({
    name                        = string
    ami                         = string
    associate_public_ip_address = bool
    az                          = string
    instance_type               = string
    key_nm                      = string
    monitoring                  = bool
    root_block_device = object({
      delete_on_termination = bool
      encrypted             = bool
      iops                  = number
      volume_size           = number
      volume_type           = string
      name                  = string
    })
  }))
}

variable "ebs_config" {
  type = list(object({
    az             = string
    encrypted      = bool
    final_snapshot = bool
    iops           = number
    size           = number
    type           = string
    vol_nm         = string
    device_nm      = string
    instance_id    = number

  }))
}

