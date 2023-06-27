aws_account_id           = "386147755255"
aws_region               = "ap-northeast-1"
shared_config_file       = "~/.aws/config"
shared_credentials_files = "~/.aws/credentials"
aws_config_profile       = "taiwan-prod"
terraform_repo_name      = "terraform-practice"
env                      = "prod"
maintainer               = "devops"
# dynamodb_table_nm        = "riman-terraform-state-locking"
# terraform_s3_bucket_nm   = "riman-terraform-state"
# terraform_s3_bucket_key  = "taiwan/prod/terraform.state"
# s3_config = {
#   "riman-terraform-state" = {
#     prevent_destroy   = true
#     versioning_status = "Enabled"
#     sse_algorithm     = "AES256"
#   }
# }

vpc_cidr_block = "10.180.0.0/16"
vpc_nm         = "dataplatform-kr-prod-workload-vpc"
azs = [
  "ap-northeast-1a",
  "ap-northeast-1c",
  "ap-northeast-1d"
]
public_sn_cidr_blocks = [
  "10.180.10.0/24",
  "10.180.30.0/24",
  "10.180.50.0/24"
]
public_sn_nms = [
  "dataplatform-kr-prod-public-sn-a",
  "dataplatform-kr-prod-public-sn-c",
  "dataplatform-kr-prod-public-sn-d"
]

private_sn_cidr_blocks = [
  "10.180.20.0/24",
  "10.180.40.0/24",
  "10.180.60.0/24"
]

private_sn_nms = [
  "dataplatform-kr-private-public-sn-a",
  "dataplatform-kr-private-public-sn-c",
  "dataplatform-kr-private-public-sn-d"
]



