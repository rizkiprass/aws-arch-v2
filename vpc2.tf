module "vpc2" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"
  # insert the 14 required variables here
  name                             = format("%s-%s-VPC", var.project, var.environment)
  cidr                             = var.cidr2
  enable_dns_hostnames             = true
  enable_dhcp_options              = true
  dhcp_options_domain_name_servers = ["AmazonProvidedDNS"]
  azs                              = ["us-east-1a", "us-east-1b"]
  public_subnets                   = [var.Public_Subnet_AZ1, var.Public_Subnet_AZ2]
  # Nat Gateway
  enable_nat_gateway = true
  single_nat_gateway = false #if true, nat gateway only create one
  # Reuse NAT IPs
  reuse_nat_ips         = true                                                      # <= if true, Skip creation of EIPs for the NAT Gateways
  external_nat_ip_ids   = [aws_eip.eip-nat-sandbox_2.id, aws_eip.eip-nat2-sandbox_2.id] #attach eip from manual create eip
  public_subnet_suffix  = "public"
  private_subnet_suffix = "private"
  intra_subnet_suffix   = "data"

  # VPC Flow Logs (Cloudwatch log group and IAM role will be created)
  enable_flow_log                      = false
  create_flow_log_cloudwatch_log_group = false
  create_flow_log_cloudwatch_iam_role  = false
  flow_log_max_aggregation_interval    = 60

  tags = local.common_tags
}

resource "aws_eip" "eip-nat-sandbox_2" {
  vpc = true
  tags = merge(local.common_tags, {
    Name = format("%s-production-EIP", var.project)
  })
}

resource "aws_eip" "eip-nat2-sandbox_2" {
  vpc = true
  tags = merge(local.common_tags, {
    Name = format("%s-production-EIP2", var.project)
  })
}