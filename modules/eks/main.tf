resource "aws_eks_cluster" "cluster" {
  count    = length(var.eks_config) > 0 ? length(var.eks_config) : 0
  name     = var.eks_config[count.index].cluster_nm
  role_arn = var.eks_cluster_role
  vpc_config {
    endpoint_private_access = var.eks_config[count.index].vpc_config_endpoint_private_access
    endpoint_public_access  = var.eks_config[count.index].vpc_config_endpoint_public_access
    public_access_cidrs     = var.eks_config[count.index].vpc_config_public_access_cidr
    security_group_ids      = var.eks_cluster_security_group_ids == [] ? null : var.eks_cluster_security_group_ids
    subnet_ids              = var.eks_cluster_subnet_ids
  }
  enabled_cluster_log_types = var.eks_config[count.index].enabled_cluster_log_types == [] ? null : var.eks_config[count.index].enabled_cluster_log_types
  kubernetes_network_config {
    service_ipv4_cidr = var.eks_config[count.index].k8s_network_config_service_ipv4_cidr == "" ? null : var.eks_config[count.index].k8s_network_config_service_ipv4_cidr
  }
  version = var.eks_config[count.index].cluster_version
  tags = {
    Name = var.eks_config[count.index].cluster_nm
  }
}

resource "aws_eks_node_group" "node_group" {
  count           = length(var.eks_config) > 0 ? length(var.eks_config) : 0
  cluster_name    = aws_eks_cluster.cluster[count.index].name
  node_group_name = var.eks_config[count.index].ng_nm
  node_role_arn   = var.eks_ng_role
  scaling_config {
    desired_size = var.eks_config[count.index].ng_desired_size
    max_size     = var.eks_config[count.index].ng_max_size
    min_size     = var.eks_config[count.index].ng_min_size

  }
  subnet_ids           = var.eks_ng_subnet_ids
  ami_type             = var.eks_config[count.index].ng_ami_type == "" ? null : var.eks_config[count.index].ng_ami_type
  capacity_type        = var.eks_config[count.index].ng_capacity_type
  disk_size            = var.eks_config[count.index].ng_disk_size
  force_update_version = var.eks_config[count.index].ng_force_update_version
  instance_types       = var.eks_config[count.index].ng_instance_types
  remote_access {
    ec2_ssh_key               = var.eks_config[count.index].ng_ec2_ssh_key
    source_security_group_ids = var.eks_ng_security_group_ids == [] ? null : var.eks_ng_security_group_ids
  }
  update_config {
    max_unavailable = var.eks_config[count.index].ng_max_unavailable
  }
  version = var.eks_config[count.index].ng_version
  tags = {
    Name = var.eks_config[count.index].ng_nm
  }
}

# resource "aws_eks_identity_provider_config" "oidc" {
#   cluster_name = 
#   oidc {
#     client_id =
#     issuer_url = 
#   }
# }

resource "aws_eks_addon" "cluster_addon" {
  count         = length(var.eks_addon_config) > 0 ? length(var.eks_addon_config) : 0
  cluster_name  = var.eks_addon_config[count.index].cluster_nm
  addon_name    = var.eks_addon_config[count.index].addon_nm
  addon_version = var.eks_addon_config[count.index].addon_version
  # resolve_conflicts_on_create = var.eks_addon_config[count.index].resolve_conflicts_on_create
  # resolve_conflicts_on_update = var.eks_addon_config[count.index].resolve_conflicts_on_update
  resolve_conflicts = var.eks_addon_config[count.index].resolve_conflicts
  preserve          = var.eks_addon_config[count.index].preserve
  #service_account_role_arn = var.eks_cluster_role
}
