####WAF S3
resource "aws_s3_bucket" "waf-log" {
  bucket = "sandbox-waf-log"

  tags = merge(local.common_tags, {
    Name        = format("%s-%s-waf-log", var.Customer, var.environment),
  })
}

resource "aws_s3_bucket_acl" "waf-log-acl" {
  bucket = aws_s3_bucket.alb-log.id
  acl    = "private"
}
####CF S3
resource "aws_s3_bucket" "cf-log" {
  bucket = "sandbox-cloudfront-log"

  tags = merge(local.common_tags, {
    Name        = format("%s-%s-cloudfront-log", var.Customer, var.environment),
  })
}

resource "aws_s3_bucket_acl" "cloudfront-log-acl" {
  bucket = aws_s3_bucket.alb-log.id
  acl    = "private"
}
####ALB S3
resource "aws_s3_bucket" "alb-log" {
  bucket = "sandbox-alb-log"

  tags = merge(local.common_tags, {
    Name        = format("%s-%s-alb-log", var.Customer, var.environment),
  })
}

resource "aws_s3_bucket_acl" "alb-log-acl" {
  bucket = aws_s3_bucket.alb-log.id
  acl    = "private"
}