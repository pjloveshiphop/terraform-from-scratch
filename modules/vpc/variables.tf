variable "vpc_config" {
  type = map(object({
    cidr_block            = string
    instance_tenancy      = string # default | dedicated
    enable_dns_support    = bool   #true | false
    enable_dns_hostnames  = bool   #true | false
    azs                   = list(string)
    public_cidr_blocks    = list(string)
    public_sn_nms         = list(string)
    private_cidr_blocks   = list(string)
    private_sn_nms        = list(string)
    igw_nm                = string
    ngw_connectivity_type = string
    ngw_private_ip        = string
    ngw_nm                = string
    # public_rtb_route = list(object({
    #   cidr_block                 = string
    #   ipv6_cidr_block            = string
    #   destination_prefix_list_id = string
    #   gateway_id                 = string
    #   nat_gateway_id             = string
    #   transit_gateway_id         = string
    #   vpc_endpoint_id            = string
    #   vpc_peering_connection_id  = string
    # }))
    public_rtb_nm = string
  }))
  description = "map of object of vpc configs"
}
