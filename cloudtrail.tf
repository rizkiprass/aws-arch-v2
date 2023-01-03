module "cloudtrail" {
  source = "cloudposse/cloudtrail/aws"
  # Cloud Posse recommends pinning every module to a specific version
  # version     = "x.x.x"
  namespace = "sandbox"
  #  s3_key_prefix                 = "mgmt"
  stage                         = "dev"
  name                          = "trail"
  enable_log_file_validation    = true
  include_global_service_events = true
  is_multi_region_trail         = false
  enable_logging                = true
  s3_bucket_name                = module.cloudtrail_s3_bucket.bucket_id
  kms_key_arn                   = "arn:aws:kms:us-west-2:272547513321:key/fbcca214-b78d-493b-915d-d75e4483e30a"
}

module "cloudtrail_s3_bucket" {
  source = "cloudposse/cloudtrail-s3-bucket/aws"
  # Cloud Posse recommends pinning every module to a specific version
  # version     = "x.x.x"
  namespace = "sandbox"
  stage     = "dev"
  name      = "trail" #next update with management trail
  #will create bucket name sandbox-dev-trail
}