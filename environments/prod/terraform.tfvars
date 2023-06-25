aws_account_id           = "386147755255"
aws_region               = "ap-northeast-1"
shared_config_file       = "~/.aws/config"
shared_credentials_files = "~/.aws/credentials"
aws_config_profile       = "taiwan-prod"
terraform_repo_name      = "terraform-practice"
env                      = "prod"
maintainer               = "devops"
dynamodb_table_nm        = "riman-terraform-state-locking"
# terraform_s3_bucket_nm   = "riman-terraform-state"
# terraform_s3_bucket_key  = "taiwan/prod/terraform.state"
s3_config = {
  "riman-terraform-state" = {
    prevent_destroy   = true
    versioning_status = "Enabled"
    sse_algorithm     = "AES256"
  }
}

vpc_config = {
  "saturn-tw-prod-workload-vpc" = {
    cidr_block           = "10.180.0.0/16"
    instance_tenancy     = "default"
    enable_dns_support   = true
    enable_dns_hostnames = true
    azs                  = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
    public_cidr_blocks   = ["10.180.10.0/24", "10.180.20.0/24", "10.180.30.0/24"]
    public_sn_nms        = ["saturn-tw-prod-workload-public-sn-a", "saturn-tw-prod-workload-public-sn-c", "saturn-tw-prod-workload-public-sn-d"]

  }
}
