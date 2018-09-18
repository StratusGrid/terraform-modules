resource "aws_s3_bucket" "site-logging" {
  bucket = "logging-${var.site_bucket_unique_name}"

  lifecycle_rule {
    id = "log"
    enabled = true

    transition {
      days = 90
      storage_class = "GLACIER"
    }

    expiration {
      days = 2557
    }
  }
  
}

resource "aws_s3_bucket_policy" "site-logging" {
  bucket = "${aws_s3_bucket.site-logging.bucket}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "awslogsdelivery",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::162777425019:root"
            },
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::logging-${var.site_bucket_unique_name}/*"
        }
    ]
}
EOF
}
