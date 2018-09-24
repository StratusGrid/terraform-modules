resource "aws_iam_user" "terraform_users" {
  count = "${var.terraform_users_count}"
  name  = "${var.terraform_users[count.index]}"
}
