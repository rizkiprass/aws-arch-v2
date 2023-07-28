locals {
  web_name = format("%s-%s-web", var.customer, var.environment)
}

//Server Private web
resource "aws_instance" "web-app" {
  ami                         = var.ami-centos-stream-9
  instance_type               = "r5.xlarge"
  associate_public_ip_address = "false"
  key_name                    = "pb-web-key"
  subnet_id                   = module.vpc.private_subnets[0]
  iam_instance_profile        = aws_iam_instance_profile.ssm-profile.name
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }
  vpc_security_group_ids = [aws_security_group.web-app-sg.id]
  root_block_device {
    volume_size           = 256
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
    Name                = local.web_name,
    OS                  = "Centos",
    Backup              = "DailyBackup" # TODO: Set Backup Rules
  })
}