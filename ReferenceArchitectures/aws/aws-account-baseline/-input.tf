variable "account_name" {
  type = "string"
  default = ""
}

variable "account_numbers" {
  type = "list"
  default = [""]
}

variable "region" {
  type = "string"
  default = "us-east-1"
}


variable "access_key" {
  type = "string"
}

variable "secret_key" {
  type = "string"
}
