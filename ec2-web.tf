locals {
  web_name = format("%s-%s-app", var.project, var.environment)
}

//Server Private web
resource "aws_instance" "web-app" {
  ami                         = "ami-03061e0e2ed8c17a0" #centos stream 9.0
  instance_type               = "t3.medium"
  associate_public_ip_address = "false"
  key_name                    = "mika-stikes-app-key"
  subnet_id                   = module.vpc.private_subnets[0]
  iam_instance_profile        = aws_iam_instance_profile.ssm-profile.name
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }
  vpc_security_group_ids = [aws_security_group.application-sg.id]
  root_block_device {
    volume_size           = 100
    volume_type           = "gp3"
    iops                  = 3000
    encrypted             = true
    delete_on_termination = true
    tags = merge(local.common_tags, {
      Name = format("%s-ebs", local.web_name)
    })
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = merge(local.common_tags, {
    Name   = local.web_name,
    OS     = "Centos",
    Backup = "DailyBackup" # TODO: Set Backup Rules
  })
}