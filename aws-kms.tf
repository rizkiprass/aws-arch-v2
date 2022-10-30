module "kms-cwatch-flowlogs-kms" {
  source         = "./modules/aws-kms"
  alias_name     = format("%s-%s-cwatch-logs", var.Customer, var.environment)
  description    = "KMS CMK for vpc flowlogs cloudwatch"
  environment    = var.environment
  product_domain = "CWatch"
  region         = var.region
  key_policy     = true
}