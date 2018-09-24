example usage:

module "terraform_users" {
  source = "github.com/StratusGrid/terraform-modules//SingleFunctionModules/aws/iam-terraform-users"
  terraform_users_count = "1"
  terraform_users = [
    "terraform"
  ]
}
