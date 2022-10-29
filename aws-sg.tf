######
# Security Group Port Rules
######
variable "mongodb" {
  type = map(any)
  default = {
    "ssh"     = 22
    "mongodb" = 27017
  }
}

variable "alb-port-list" {
  type = map(any)
  default = {
    "http"  = 80
    "https" = 443
  }
}

variable "bastion-host-port-list" {
  type = map(any)
  default = {
    "http"  = 80
    "https" = 443
    "ssh"   = 22
  }
}

variable "application-port-list" {
  type = map(any)
  default = {
    "http"  = 80
    "https" = 443
    "ssh"   = 22
  }
}

variable "data-port-list" {
  type = map(any)
  default = {
    "http"  = 80
    "https" = 443
    "ssh"   = 22
  }
}

//Bastion SG
resource "aws_security_group" "bastion-host-sg" {
  name        = format("%s-%s-bastion-host-sg", var.project, var.environment)
  description = format("%s-%s-bastion-host-sg", var.project, var.environment)
  vpc_id      = module.vpc.vpc_id
  dynamic "ingress" {
    for_each = var.bastion-host-port-list
    content {
      from_port = ingress.value
      to_port   = ingress.value
      protocol  = "tcp"
      cidr_blocks = [
      "0.0.0.0/0"]
      description = ingress.key
    }
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1" //all traffic
    cidr_blocks = [
    "0.0.0.0/0"]
  }
  tags = merge(local.common_tags, {
    Name = format("%s-%s-bastion-host-sg", var.project, var.environment),
  })
  lifecycle { ignore_changes = [ingress, egress] }

}

#variable "openvpn-sg-port" {
#  type = map(any)
#  default = {
#    "openvpn"   = 943
#    "openvpn2"  = 945
#    "openvpn3"  = 1194
#    "openvpn4"  = 443
#    "openvpn5"  = 22
#  }
#}
#
#resource "aws_security_group" "openvpn-sg" {
#  name        = format("%s-%s-openvpn-sg", var.Customer, var.environment)
#  description = format("%s-%s-openvpn-sg", var.Customer, var.environment)
#  vpc_id      = aws_vpc.vpc.id
#  dynamic "ingress" {
#    for_each = var.openvpn-sg-port
#    content {
#      from_port = ingress.value
#      to_port   = ingress.value
#      protocol  = "tcp"
#      cidr_blocks = [
#      "0.0.0.0/0"]
#      description = ingress.key
#    }
#  }
#
#  egress {
#    from_port = 0
#    to_port   = 0
#    protocol  = "-1"
#    cidr_blocks = [
#    "0.0.0.0/0"]
#  }
#  tags = merge(local.common_tags, {
#    Name = format("%s-%s-openvpn-sg", var.Customer, var.environment),
#  })
#}

//Prod-App-sg
resource "aws_security_group" "web-sg" {
  name        = format("%s-%s-web-sg", var.Customer, var.environment)
  description = format("%s-%s-web-sg", var.Customer, var.environment)
  vpc_id      = module.vpc.vpc_id
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [
    "10.0.0.0/16"]
    description = "ssh"
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = [
    "10.0.0.0/16"]
    description = "web"
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = [
    "10.0.0.0/16"]
    description = "https"
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
    "0.0.0.0/0"]
  }
  lifecycle {
    create_before_destroy = false
  }

  tags = merge(local.common_tags, {
    Name = format("%s-%s-App-sg", var.Customer, var.environment)
  })
}

//Prod-Data-sg
resource "aws_security_group" "rdsmysql-sg" {
  name        = format("%s-%s-rdsmysql-sg", var.Customer, var.environment)
  description = format("%s-%s-rdsmysql-sg", var.Customer, var.environment)
  vpc_id      = module.vpc.vpc_id
  ingress {
    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"
    cidr_blocks = [
    "10.0.0.0/16"]
    description = "mysql"
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [
    "10.0.0.0/16"]
    description = "ssh"
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [
    "10.0.0.0/16"]
    description = "ssh"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(local.common_tags, {
    Name = format("%s-%s-Datadb-sg", var.Customer, var.environment)
  })
}

# ALB Security Group
resource "aws_security_group" "alb-sg" {
  name        = format("%s-%s-alb-sg", var.project, var.environment)
  description = format("%s-%s-alb-sg", var.project, var.environment)
  vpc_id      = module.vpc.vpc_id
  dynamic "ingress" {
    for_each = var.alb-port-list
    content {
      from_port = ingress.value
      to_port   = ingress.value
      protocol  = "tcp"
      cidr_blocks = [
      "0.0.0.0/0"]
      description = ingress.key
    }
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
    "0.0.0.0/0"]
  }
  tags = merge(local.common_tags, {
    Name = format("%s-%s-alb-sg", var.project, var.environment),
  })
  lifecycle { create_before_destroy = true }

}

////alb-sg
//resource "aws_security_group" "web-alb-sg" {
//  name        = format("%s-%s-web-alb-sg", var.Customer, var.environment)
//  description = format("%s-%s-web-alb-sg", var.Customer, var.environment)
//  vpc_id      = module.vpc.vpc_id
//  ingress {
//    from_port = 80
//    to_port   = 80
//    protocol  = "tcp"
//    cidr_blocks = [
//    "0.0.0.0/0"]
//    description = "web"
//  }
//
//  ingress {
//    from_port = 443
//    to_port   = 443
//    protocol  = "tcp"
//    cidr_blocks = [
//    "0.0.0.0/0"]
//    description = "https"
//  }
//
//  egress {
//    from_port = 0
//    to_port   = 0
//    protocol  = "-1"
//    cidr_blocks = [
//    "0.0.0.0/0"]
//  }
//  lifecycle {
//    create_before_destroy = true
//  }
//
//  tags = merge(local.common_tags, {
//    Name = format("%s-%s-web-alb-sg", var.Customer, var.environment)
//  })
//}

//Jenkins-App-sg
resource "aws_security_group" "Jenkins-App-sg" {
  name        = format("%s-jenkins-app-sg", var.Customer)
  description = format("%s-jenkins-app-sg", var.Customer)
  vpc_id      = module.vpc.vpc_id
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]
    description = "ssh"
  }

  ingress {
    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]
    description = "web"
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]
    description = "https"
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
    "0.0.0.0/0"]
  }
  lifecycle {
    create_before_destroy = true
  }

  tags = merge(local.common_tags, {
    Name = format("%s-jenkins-sg", var.Customer)
  })
}