# terraform {
#   backend "s3" {
#     access_key      = ""
#     bucket          = "account_name-remote-state-backend"
#     dynamodb_table  = "account_name-remote-state-backend"
#     encrypt         = true
#     key             = "account_name-remote-state-backend"
#     kms_key_id      = ""
#     region          = "us-east-1"
#     secret_key      = ""
#   }
# }

provider "aws" {
  allowed_account_ids = "${var.account_numbers}"
  region              = "${var.region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

module "terraform_users" {
  source = "github.com/StratusGrid/terraform-modules//SingleFunctionModules/aws/iam-terraform-users"
  terraform_users_count = "1"
  terraform_users = [
    "terraform"
  ]
}

module "log_bucket" {
  name_prefix = "${var.account_name}"
  source = "github.com/StratusGrid/terraform-modules//SingleFunctionModules/aws/log-bucket"
}

module "remote_state_backend" {
  log_bucket_id = "${module.log_bucket.id}"
  name_prefix = "${var.account_name}"
 source = "github.com/StratusGrid/terraform-modules//ReferenceArchitectures/aws/s3-remote-state-backend"
  user_name_count = "1"
  user_names = [
    "terraform-remote-state"
  ]
}
