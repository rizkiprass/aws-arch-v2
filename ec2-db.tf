locals {
  db_name = format("%s-%s-db", var.customer, var.environment)
}

//Server Private db
resource "aws_instance" "db" {
  ami                         = var.ami-centos-stream-9 //centos stream 9
  instance_type               = "m5.2xlarge"
  associate_public_ip_address = "false"
  key_name                    = "pb-db-key"
  subnet_id                   = module.vpc.database_subnets[0]
  iam_instance_profile        = aws_iam_instance_profile.ssm-profile.name
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }
  vpc_security_group_ids = [aws_security_group.db-sg.id]
  root_block_device {
    volume_size           = 256
    volume_type           = "gp3"
    iops                  = 3000
    encrypted             = true
    delete_on_termination = true
    tags = merge(local.common_tags, {
      Name = format("%s-ebs", local.db_name)
    })
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = merge(local.common_tags, {
    Name   = local.db_name,
    OS     = "Ubuntu",
    Backup = "DailyBackup" # TODO: Set Backup Rules
  })
}