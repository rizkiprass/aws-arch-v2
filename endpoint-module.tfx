//module "vpc_endpoints" {
//  source = "modules/vpc-endpoints"
//
//  vpc_id             = module.vpc.vpc_id
//  security_group_ids = [data.aws_security_group]
//
//  endpoints = {
//    s3 = {
//      service = "s3"
//      tags = merge(local.common_tags, {
//    Name                = format("%s-%s-endpoint-s3", var.Customer, var.environment),
//  })
//    }
//  }
//
//
//  data "aws_security_group" "default" {
//  name   = "endpoint-sg"
//  vpc_id = module.vpc.vpc_id
//}