# module "s3" {
#   source    = "../../modules/s3"
#   s3_config = var.s3_config
# }

# module "dynamodb" {
#   source            = "../../modules/dynamodb"
#   dynamodb_table_nm = var.dynamodb_table_nm
# }

module "vpc" {
  source     = "../../modules/vpc"
  vpc_config = var.vpc_config
}
