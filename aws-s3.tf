####WAF S3
resource "aws_s3_bucket" "waf-log" {
  bucket = "sandbox-waf-log"

  tags = merge(local.common_tags, {
    Name = format("%s-%s-waf-log", var.Customer, var.environment),
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
    Name = format("%s-%s-cloudfront-log", var.Customer, var.environment),
  })
}

resource "aws_s3_bucket_acl" "cloudfront-log-acl" {
  bucket = aws_s3_bucket.alb-log.id
  acl    = "private"
}
####ALB S3
resource "aws_s3_bucket" "alb-log" {
  bucket = "sandbox-alb-log-301"

  tags = merge(local.common_tags, {
    Name = format("%s-%s-alb-log", var.Customer, var.environment),
  })
}

resource "aws_s3_bucket_acl" "alb-log-acl" {
  bucket = aws_s3_bucket.alb-log.id
  acl    = "private"
}

####static web s3
resource "aws_s3_bucket" "cms" {
  bucket = "cms.rp-server.site"

  tags = merge(local.common_tags, {
    Name = format("%s-%s-cms.rp-server.site", var.Customer, var.environment),
  })
}