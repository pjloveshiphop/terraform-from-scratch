variable "vpc_config" {
  type = map(object({
    cidr_block           = string
    instance_tenancy     = string # default | dedicated
    enable_dns_support   = bool   #true | false
    enable_dns_hostnames = bool   #true | false
  }))
}
