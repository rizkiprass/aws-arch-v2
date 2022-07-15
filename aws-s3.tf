#module "s3_bucket" {
#  source = "terraform-aws-modules/s3-bucket/aws"
#
#  bucket = "sandbox-s3-bucket-1122"
#  acl    = "private"
#
#  versioning = {
#    enabled = true
#  }
#
#}