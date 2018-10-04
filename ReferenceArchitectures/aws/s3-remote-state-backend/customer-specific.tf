resource "aws_kms_key" "specific_remote_state_backend" {
  count = "${var.customer_specific_count}"
  description         = "Key for ${var.customer_specific_names[count.index]} remote state backend"
  enable_key_rotation = true
}

resource "aws_kms_alias" "specific_state_backend" {
  count = "${var.customer_specific_count}"
  name          = "alias/${var.name_prefix}-remote-state-backend-${var.customer_specific_names[count.index]}"
  target_key_id = "${aws_kms_key.specific_remote_state_backend.*.key_id[count.index]}"
}

resource "aws_iam_user" "specific_remote_state_backend" {
  count = "${var.customer_specific_count}"
  name  = "${var.customer_specific_names[count.index]}"
}

resource "aws_iam_group" "specific_remote_state_backend" {
  count = "${var.customer_specific_count}"
  name = "remote-state-backend-${var.customer_specific_names[count.index]}"
}

resource "aws_dynamodb_table" "specific_remote_state_backend" {
  count = "${var.customer_specific_count}"
  attribute {
    name = "LockID"
    type = "S"
  }
  hash_key        = "LockID"
  name            = "${var.customer_specific_names[count.index]}-remote-state-backend"
  read_capacity   = 1
  write_capacity  = 1
}

data "aws_iam_policy_document" "specific_remote_state_backend_group" {
  count = "${var.customer_specific_count}"
  statement {
    actions   = [
      "s3:ListBucket",
      "s3:GetBucketLocation",
      "s3:ListBucketMultipartUploads"
    ]
    resources = [
      "${aws_s3_bucket.remote_state_backend.arn}"
    ]
    sid       = "AllowAccessToRemoteStateBackendBucket"
  }
  statement {
    actions   = [
      "s3:AbortMultipartUpload",
      "s3:Get*",
      "s3:List*",
      "s3:Put*"
    ]
    resources = [
      "${aws_s3_bucket.remote_state_backend.arn}/${var.customer_specific_names[count.index]}"
    ]
    sid       = "AllowAccessToRemoteStateBackendKey"
  }
  statement {
    actions   = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:DescribeKey",
      "kms:GenerateDataKey*",
      "kms:ReEncrypt*"
    ]
    resources = [
      "${aws_kms_key.specific_remote_state_backend.*.arn[count.index]}"
    ]
    sid       = "AllowUseOfRemoteStateBackendKMSKey"
  }
  statement {
    actions   = [
      "dynamodb:Batch*",
      "dynamodb:DeleteItem",
      "dynamodb:Describe*",
      "dynamodb:Get*",
      "dynamodb:PutItem",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:UpdateItem"
    ]
    resources = [
      "${aws_dynamodb_table.specific_remote_state_backend.*.arn[count.index]}"
    ]
    sid       = "AllowAccessToLockTable"
  }
}

resource "aws_iam_group_policy" "specific_remote_state_backend" {
  count = "${var.customer_specific_count}"
  name    = "remote-state-backend-access-${var.customer_specific_names[count.index]}"
  group   = "${aws_iam_group.specific_remote_state_backend.*.id[count.index]}"
  policy  = "${element(data.aws_iam_policy_document.specific_remote_state_backend_group.*.json, count.index)}"
}

resource "aws_iam_group_membership" "specific_remote_state_backend" {
  count = "${var.customer_specific_count}"
  group = "${aws_iam_group.specific_remote_state_backend.*.name[count.index]}"
  name  = "remote-state-backend-membership-${var.customer_specific_names[count.index]}"
  users = ["${aws_iam_user.specific_remote_state_backend.*.name[count.index]}"]
}
