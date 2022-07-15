variable "openvpn-sg-port" {
  type = map(any)
  default = {
    "openvpn"   = 943
    "openvpn2"  = 945
    "openvpn3"  = 1194
    "openvpn4"  = 443
    "openvpn5"  = 22
  }
}

resource "aws_security_group" "openvpn-sg" {
  name        = format("%s-%s-openvpn-sg", var.Customer, var.environment)
  description = format("%s-%s-openvpn-sg", var.Customer, var.environment)
  vpc_id      = aws_vpc.vpc.id
  dynamic "ingress" {
    for_each = var.openvpn-sg-port
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
    Name = format("%s-%s-openvpn-sg", var.Customer, var.environment),
  })
}

//Prod-App-sg
resource "aws_security_group" "Prod-App-sg" {
  name = format("%s-%s-App-sg", var.Customer, var.environment)
  description = format("%s-%s-App-sg", var.Customer, var.environment)
  vpc_id = aws_vpc.vpc.id
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      "10.0.0.0/16"]
    description = "ssh"
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [
      "10.0.0.0/16" ]
    description = "web"
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [
      "10.0.0.0/16" ]
    description = "https"
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  lifecycle {
    create_before_destroy = true
  }

  tags = merge(local.common_tags, {
    Name = format("%s-%s-App-sg", var.Customer, var.environment)
  })
}

//Dev-App-sg
resource "aws_security_group" "Dev-App-sg" {
  name = format("%s-dev-App-sg", var.Customer)
  description = format("%s-dev-App-sg", var.Customer)
  vpc_id = aws_vpc.vpc.id
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      "10.0.0.0/16"]
    description = "ssh"
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [
      "10.0.0.0/16" ]
    description = "web"
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [
      "10.0.0.0/16" ]
    description = "https"
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  lifecycle {
    create_before_destroy = true
  }

  tags = merge(local.common_tags, {
    Name = format("%s-dev-vectrkdev-jkt01-sg", var.Customer)
  })
}

//Prod-Data-sg
resource "aws_security_group" "Prod-Data-sg" {
  name = format("%s-%s-Datadb-sg", var.Customer, var.environment)
  description = format("%s-%s-Datadb-sg", var.Customer, var.environment)
  vpc_id = aws_vpc.vpc.id
  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = [
      "10.0.10.159/32"]
    description = "mysql"
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      "10.0.10.159/32"]
    description = "ssh"
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      "10.0.10.44/32"]
    description = "ssh"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(local.common_tags, {
    Name = format("%s-%s-Datadb-sg", var.Customer, var.environment)
  })
}

//alb-sg
resource "aws_security_group" "web-alb-sg" {
  name = format("%s-%s-web-alb-sg", var.Customer, var.environment)
  description = format("%s-%s-web-alb-sg", var.Customer, var.environment)
  vpc_id = aws_vpc.vpc.id
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0" ]
    description = "web"
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0" ]
    description = "https"
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  lifecycle {
    create_before_destroy = true
  }

  tags = merge(local.common_tags, {
    Name = format("%s-%s-web-alb-sg", var.Customer, var.environment)
  })
}