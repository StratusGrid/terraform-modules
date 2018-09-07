data "aws_acm_certificate" "site-data" {
  domain      = "${var.certificate_subject_name}"
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}
