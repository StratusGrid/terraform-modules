variable "site_bucket_unique_name" {
  type = "string"
}

variable "certificate_subject_name" {
  type = "string"
}

variable "cloudfront_alias_list" {
  type = "list"
  default = []
}

variable "cloudfront_price_class" {
  type = "string"
  default = "PriceClass_200"
}

variable "index_document" {
  type = "string"
  default = "index.html"
}

variable "error_document" {
  type = "string"
  default = "error.html"
}
