resource "aws_s3_bucket" "site-data" {
  bucket = "site-${var.site_bucket_unique_name}"
  acl    = "public-read"
  website {
    index_document = "${var.index_document}"
    error_document = "${var.error_document}"
  }
}

resource "aws_s3_bucket_policy" "site-data" {
  bucket = "${aws_s3_bucket.site-data.bucket}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowPublicRead",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::site-${var.site_bucket_unique_name}/*"
        }
    ]
}
EOF
}
