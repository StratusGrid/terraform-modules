variable "name_prefix" {
  type = "string"
}

variable "log_bucket_id" {
  type = "string"
}

variable "user_name_count" {
  type = "string"
}

variable "user_names" {
  type = "list"
}

variable "customer_specific_count" {
  type = "string"
  default = "0"
}

variable "customer_specific_names" {
  type = "list"
  default = []
}
