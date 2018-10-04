resource "aws_dynamodb_table" "remote_state_backend" {
  attribute {
    name = "LockID"
    type = "S"
  }
  hash_key        = "LockID"
  name            = "${var.name_prefix}-remote-state-backend"
  read_capacity   = 1
  write_capacity  = 1
}
