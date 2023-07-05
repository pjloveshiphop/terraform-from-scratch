# module "s3" {
#   source    = "../../modules/s3"
#   s3_config = var.s3_config
# }

# module "dynamodb" {
#   source            = "../../modules/dynamodb"
#   dynamodb_table_nm = var.dynamodb_table_nm
# }

module "vpc" {
  source                 = "../../modules/vpc"
  vpc_cidr_block         = var.vpc_cidr_block
  vpc_nm                 = var.vpc_nm
  azs                    = var.azs
  public_sn_nms          = var.public_sn_nms
  public_sn_cidr_blocks  = var.public_sn_cidr_blocks
  private_sn_nms         = var.private_sn_nms
  private_sn_cidr_blocks = var.private_sn_cidr_blocks
  eip_nms                = var.eip_nms
  cgw_config             = var.cgw_config
  sg_config              = var.sg_config
  sg_rule                = var.sg_rule
}

# module "ec2" {
#   source     = "../../modules/ec2"
#   key_config = var.key_config
#   ec2_config = var.ec2_config
#   ebs_config = var.ebs_config
#   sg_id      = ["${module.vpc.test_sg_id}"]
#   sn_id      = module.vpc.public_sn0_id

# }

# module "rds" {
#   source                 = "../../modules/rds"
#   db_sg_config           = var.db_sg_config
#   private_sn_ids         = [module.vpc.private_sn0_id, module.vpc.private_sn1_id, module.vpc.private_sn2_id]
#   db_pg_config           = var.db_pg_config
#   vpc_security_group_ids = [module.vpc.dataplatform_kr_prod_rds_sg_id]
#   db_instance_config     = var.db_instance_config

# }

module "iam" {
  source                       = "../../modules/iam"
  iam_policy_config            = var.iam_policy_config
  iam_group_config             = var.iam_group_config
  iam_group_member_config      = var.iam_group_member_config
  iam_user_config              = var.iam_user_config
  iam_user_create_access_key   = var.iam_user_create_access_key
  iam_policy_attachment_config = var.iam_policy_attachment_config
  iam_role_config              = var.iam_role_config
}
