To use this module, you import it then use it as policy bucket policy resource. Example below:

module "encrypted_transit_bucket_policy" {
  bucket_arn    = "${aws_s3_bucket.remote_state_backend.arn}"
  kms_key_arns  = ["${aws_kms_key.remote_state_backend.arn}"]
  source        = "./s3-bucket-policy-encrypted-transit-only"
}

resource "aws_s3_bucket_policy" "remote_state_backend" {
  bucket = "${aws_s3_bucket.remote_state_backend.id}"
  policy = "${module.encrypted_transit_bucket_policy.json}"
}
