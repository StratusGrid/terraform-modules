resource "aws_iam_group" "terraform_users" {
  name = "terraform-users"
}

data "aws_iam_policy_document" "terraform_users" {
  statement {
    actions   = [
      "*"
    ]
    resources = [
      "*"
    ]
    effect       = "Allow"
    sid          = "AllowAny"
  }
}

resource "aws_iam_group_policy" "terraform_users" {
  name    = "terraform-users-access"
  group   = "${aws_iam_group.terraform_users.id}"
  policy  = "${data.aws_iam_policy_document.remote_state_backend_group.json}"
}

resource "aws_iam_group_membership" "terraform_users" {
  group = "${aws_iam_group.terraform_users.name}"
  name  = "terraform-users-membership"
  users = ["${aws_iam_user.terraform_users.*.name}"]
}
