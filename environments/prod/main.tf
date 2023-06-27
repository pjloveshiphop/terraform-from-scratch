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



}

# module "security" {
#   source    = "../../modules/security"
#   sg_config = var.sg_config
#   vpc_id    = module.vpc.vpc_id

# }
