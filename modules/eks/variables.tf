# ========================= provided from outputs =========================
variable "eks_cluster_role" {
  type        = string
  description = "arn of IAM role to be used with eks cluster(s)"
}

variable "eks_cluster_subnet_ids" {
  type        = list(string)
  description = "list of subnet ids to be used with eks cluster(s)"
}

variable "eks_cluster_security_group_ids" {
  type        = list(string)
  description = "list of security group ids to be used with eks cluster(s)"
}
variable "eks_ng_role" {
  type        = string
  description = "arn of IAM role to b e used with eks node group(s)"
}

variable "eks_ng_subnet_ids" {
  type        = list(string)
  description = "list of subnet ids to be used with eks node group(s)"
}

variable "eks_ng_security_group_ids" {
  type        = list(string)
  description = "list of security group ids to be used with eks node group(s)"
}

# ========================= module variable(s) =========================
variable "eks_config" {
  type = list(object({
    cluster_nm                           = string
    vpc_config_endpoint_private_access   = bool
    vpc_config_endpoint_public_access    = bool
    vpc_config_public_access_cidr        = list(string)
    enabled_cluster_log_types            = list(string)
    k8s_network_config_service_ipv4_cidr = string
    cluster_version                      = string
    ng_nm                                = string
    ng_ami_type                          = string
    ng_capacity_type                     = string
    ng_disk_size                         = number
    ng_force_update_version              = bool
    ng_instance_types                    = list(string)
    ng_ec2_ssh_key                       = string
    ng_version                           = string
    ng_desired_size                      = number
    ng_max_size                          = number
    ng_min_size                          = number
    ng_max_unavailable                   = number
  }))
}

variable "eks_addon_config" {
  type = list(object({
    cluster_nm        = string
    addon_nm          = string
    addon_version     = string
    resolve_conflicts = string
    # resolve_conflicts_on_create = string
    # resolve_conflicts_on_update = string
    preserve = bool
  }))
}

