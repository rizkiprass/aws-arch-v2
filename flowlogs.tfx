#FlowLogs
locals {
  vpc-name= format("%s-%s-VPC", var.project, var.environment)
}
resource "aws_flow_log" "flow-logs" {
  log_destination      = aws_cloudwatch_log_group.prod-vpc-flowlogs.arn
  log_destination_type = "cloud-watch-logs"
  iam_role_arn         = aws_iam_role.cloudwatch-role.arn
  traffic_type         = "ALL"
  vpc_id               = module.vpc.vpc_id
}

resource "aws_cloudwatch_log_group" "prod-vpc-flowlogs" {
  name              = format("flowlogs/%s",local.vpc-name)
  kms_key_id        = module.kms-cwatch-flowlogs.key_arn
  retention_in_days = 0
}

resource "aws_iam_role" "cloudwatch-role" {
  name_prefix        = format("%s-flowlog-cw-role", var.project)
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
  tags = {
    name = format("%s-flowlog-cwatch-role", local.vpc-name)
  }
}

resource "aws_iam_role_policy" "cloudwatch-logstream" {
  name_prefix = format("%s-cwatch-log-policy", local.vpc-name)
  role        = aws_iam_role.cloudwatch-role.id
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

module "kms-cwatch-flowlogs" {
  source         = "./modules/aws-kms"
  alias_name     = format("%s-%s-cwatch-logs", var.project, var.environment)
  description    = "KMS CMK for vpc flowlogs cloudwatch"
  environment    = var.environment
  product_domain = "CWatch"
  region         = "ap-southeast-1"
  key_policy     = true
}