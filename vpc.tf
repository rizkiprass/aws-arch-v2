module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"
  # insert the 14 required variables here
  name                             = format("%s-%s-VPC", var.project, var.environment)
  cidr                             = var.cidr
  enable_dns_hostnames             = true
  enable_dhcp_options              = true
  dhcp_options_domain_name_servers = ["AmazonProvidedDNS"]
  azs                              = ["us-east-1a", "us-east-1b"]
  public_subnets                   = [var.Public_Subnet_AZ1, var.Public_Subnet_AZ2]
  private_subnets                  = [var.App_Subnet_AZ1, var.App_Subnet_AZ2]
  intra_subnets                    = [var.Data_Subnet_AZ1, var.Data_Subnet_AZ2]
  # Nat Gateway
  enable_nat_gateway = true
  # Reuse NAT IPs
  reuse_nat_ips         = true
  external_nat_ip_ids   = [aws_eip.eip-nat-sandbox.id, aws_eip.eip-nat2-sandbox.id]
  public_subnet_suffix  = "web"
  private_subnet_suffix = "app"
  intra_subnet_suffix   = "data"
  tags                  = local.common_tags
}

resource "aws_eip" "eip-nat-sandbox" {
  vpc = true
  tags = merge(local.common_tags, {
    Name = format("%s-production-EIP", var.project)
  })
}

resource "aws_eip" "eip-nat2-sandbox" {
  vpc = true
  tags = merge(local.common_tags, {
    Name = format("%s-production-EIP2", var.project)
  })
}

resource "aws_eip" "eip-webmaster" {
  vpc = true
  instance = aws_instance.prod-app.id
  tags = merge(local.common_tags, {
    Name = format("%s-production-EIP-webmaster", var.project)
  })
}

resource "aws_eip" "eip-jenkins" {
  vpc = true
  instance = aws_instance.jenkins-app
  tags = merge(local.common_tags, {
    Name = format("%s-production-EIP-jenkins", var.project)
  })
}
#
#resource "aws_subnet" "subnet-db-1a" {
# vpc_id      = module.vpc.vpc_id
#  cidr_block = var.Private_Intra_AZ1
#  availability_zone = format("%sa", var.aws_region)
#}
#
#resource "aws_subnet" "subnet-db-1b" {
# vpc_id      = module.vpc.vpc_id
#  cidr_block = var.Private_Intra_AZ2
#  availability_zone = format("%sb", var.aws_region)
#}