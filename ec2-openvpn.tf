locals {
  openvpn_name = format("%s-%s-openvpn", var.customer, var.environment)
}

//AWS Instance OpenVPN AZ A Resource
resource "aws_instance" "openvpn" {
  ami                    = var.ami-ubuntu
  instance_type          = "t3.micro"
  key_name               = "pb-openvpn-key"
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.openvpn-sg.id]
    iam_instance_profile   = aws_iam_instance_profile.ssm-profile.name
  user_data = file("open-vpn.sh")

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }
  root_block_device {
    volume_size           = 8
    volume_type           = "gp3"
    iops                  = 3000
    encrypted             = true
    delete_on_termination = true
    tags = merge(local.common_tags, {
      Name = format("%s-ebs", local.openvpn_name),
    })
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = merge(local.common_tags, {
    Name   = local.openvpn_name,
    OS     = "Ubuntu",
    Backup = "DailyBackup"
  })
}

//AWS Resource for Create EIP OpenVPN
resource "aws_eip" "eipovpn" {
  instance = aws_instance.openvpn.id
  vpc      = true
  tags = merge(local.common_tags, {
    Name = format("%s-EIP", local.openvpn_name)
  })
}