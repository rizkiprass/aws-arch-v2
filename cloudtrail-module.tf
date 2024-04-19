module "aws_cloudtrail" {
  trail_name = "customer-mgmt-trail"
    source             = "trussworks/cloudtrail/aws"
    s3_bucket_name     = "customer-cloudtrail-logs"
    log_retention_days = 90
}