//Server web-App
resource "aws_instance" "web-app" {
  ami                         = "ami-0530ca8899fac469f"
  instance_type               = "t3.micro"
  associate_public_ip_address = "false"
  key_name                    = "webmaster-key"
  subnet_id                   = module.vpc.private_subnets[0]
  iam_instance_profile        = aws_iam_instance_profile.ssm-profile.name
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  root_block_device {
    volume_size           = 50
    volume_type           = "gp3"
    iops                  = 3000
    encrypted             = true
    delete_on_termination = true
    tags = merge(local.common_tags, {
      Name = format("%s-%s-webmaster-ebs", var.customer, var.environment)
    })
  }

  user_data = file("./userdata/install-apache.sh")

  lifecycle {
    ignore_changes        = [associate_public_ip_address]
    create_before_destroy = false
  }

  tags = merge(local.common_tags, {
    Name                = format("%s-%s-webmaster", var.customer, var.environment),
    start-stop-schedule = false,
    OS                  = "Ubuntu",
    Backup              = "DailyBackup" # TODO: Set Backup Rules
  })
}


########################################################

//Bastion server
resource "aws_instance" "bastion" {
  ami                         = "ami-0ceecbb0f30a902a6" #amazon linux 2
  instance_type               = "t3.medium"
  associate_public_ip_address = "false"
  key_name                    = "webmaster-key"
  subnet_id                   = module.vpc.public_subnets[0]
  iam_instance_profile        = aws_iam_instance_profile.ssm-profile.name
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }
  vpc_security_group_ids = [aws_security_group.bastion-host-sg.id]
  root_block_device {
    volume_size           = 50
    volume_type           = "gp3"
    iops                  = 3000
    encrypted             = true
    delete_on_termination = true
    tags = merge(local.common_tags, {
      Name = format("%s-%s-bastion-ebs", var.customer, var.environment)
    })
  }

  lifecycle {
    ignore_changes = [associate_public_ip_address]
  }

  tags = merge(local.common_tags, {
    Name                = format("%s-%s-bastion", var.customer, var.environment),
    start-stop-schedule = false,
    OS                  = "amazon-linux",
    Backup              = "DailyBackup" # TODO: Set Backup Rules
  })
}

############################################################

#//Server Jenkins
#resource "aws_instance" "jenkins-app" {
#  ami                         = var.ami-ubuntu
#  instance_type               = "t3.medium"
#  associate_public_ip_address = "false"
#  key_name                    = "jenkins-key"
#  subnet_id                   = module.vpc.public_subnets[0]
#  iam_instance_profile        = aws_iam_instance_profile.ssm-profile.name
#  metadata_options {
#    http_endpoint = "enabled"
#    http_tokens   = "required"
#  }
#  vpc_security_group_ids = [aws_security_group.Jenkins-App-sg.id]
#  root_block_device {
#    volume_size           = 50
#    volume_type           = "gp3"
#    iops                  = 3000
#    encrypted             = true
#    delete_on_termination = true
#    tags = merge(local.common_tags, {
#      Name = format("%s-%s-jenkins-ebs", var.customer, var.environment)
#    })
#  }
#
#  user_data = file("install_jenkins.sh")
#
#  lifecycle {
#    ignore_changes = [associate_public_ip_address]
#  }
#
#  tags = merge(local.common_tags, {
#    Name                = format("%s-%s-jenkins", var.customer, var.environment),
#    start-stop-schedule = false,
#    OS                  = "Ubuntu",
#    Backup              = "DailyBackup" # TODO: Set Backup Rules
#  })
#}


#//Server Prod-Data
#resource "aws_instance" "Prod-Data" {
#  ami                         = var.ami-ubuntu
#  instance_type               = "t2.micro"
#  associate_public_ip_address = "false"
#  key_name                    = "key-sandbox"
#  subnet_id                   = aws_subnet.subnet-data-1a.id
#  iam_instance_profile        = aws_iam_instance_profile.ssm-profile.name
#  metadata_options {
#    http_endpoint = "enabled"
#    http_tokens   = "required"
#  }
#  vpc_security_group_ids = [aws_security_group.Prod-Data-sg.id]
#  root_block_device {
#    volume_size           = 20
#    volume_type           = "gp3"
#    iops                  = 3000
#    encrypted             = true
#    delete_on_termination = true
#    tags = merge(local.common_tags, {
#      Name = format("%s-%s-data", var.customer, var.environment)
#    })
#  }
#
#  tags = merge(local.common_tags, {
#    Name                = format("%s-%s-Data-rpras", var.customer, var.environment),
#    start-stop-schedule = false,
#    OS                  = "Ubuntu",
#    Backup              = "DailyBackup" # TODO: Set Backup Rules
#  })
#}
#
################
## OpenVPN + NAT Instance
###############
#resource "aws_eip" "openvpn-nat" {
#  instance = aws_instance.openvpn.id
#  tags = merge(local.common_tags, {
#    Name = format("%s-%s-openvpn-eip", var.project, var.environment)
#  })
#}
#output "openvpn-eip" {
#  value = aws_eip.openvpn-nat.public_ip
#}
#resource "aws_instance" "openvpn" {
#  ami                  = var.ami-ubuntu
#  instance_type        = "t2.micro"
#  key_name             = "key-sandbox"
#  subnet_id            = aws_subnet.subnet-public-1a.id
#  iam_instance_profile = aws_iam_instance_profile.ssm-profile.name
#  metadata_options {
#    http_endpoint = "enabled"
#    http_tokens   = "required"
#  }
#  vpc_security_group_ids = [
#  aws_security_group.openvpn-sg.id]
#  source_dest_check = false
#  root_block_device {
#    volume_size           = 10
#    volume_type           = "gp3"
#    iops                  = 3000
#    encrypted             = true
#    delete_on_termination = true
#    tags = merge(local.common_tags, {
#      Name = format("%s-%s-openvpn-ebs", var.project, var.environment),
#    })
#  }
#  tags = merge(local.common_tags, {
#    Name                = format("%s-%s-openvpn-rpras", var.project, var.environment),
#    start-stop-schedule = false,
#    Backup              = "MonthlyBackup"
#  })
#}