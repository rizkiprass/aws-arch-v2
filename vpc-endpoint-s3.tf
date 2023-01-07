################################################################################
# VPC Endpoints Module
################################################################################

module "vpc_endpoints" {
  source = "./.terraform/modules/vpc/modules/vpc-endpoints"

  vpc_id             = module.vpc.vpc_id
  security_group_ids = []

  endpoints = {
    s3 = {
      service = "s3"
      tags = {
        Name = "s3-vpc-endpoint"
      }

    },
  }

  tags = merge(local.common_tags, {
    Name = format("%s-s3-endpoint", var.project)
  })
}