output "cloudfront_endpoint" {
  value = "${aws_cloudfront_distribution.site-cdn.domain_name}"
}

output "data_bucket" {
  value = "${aws_s3_bucket.site-data.bucket}"
}

output "logging_bucket" {
  value = "${aws_s3_bucket.site-logging.bucket}"
}
