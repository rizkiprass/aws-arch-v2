locals {
  sg_web_name = format("%s-%s-web-sg", var.customer, var.environment)
}

//Security Group web
variable "application-port-list" {
  type = map(any)
  default = {
    "http"  = 80
    "https" = 443
    "ssh"   = 22
  }
}

//Prod-App-sg
resource "aws_security_group" "web-app-sg" {
  name        = local.sg_web_name
  description = local.sg_web_name
  vpc_id      = module.vpc.vpc_id

  dynamic "ingress" {
    for_each = var.application-port-list
    content {
      from_port = ingress.value
      to_port   = ingress.value
      protocol  = "tcp"
      cidr_blocks = [
      var.cidr]
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
  lifecycle {
    create_before_destroy = true
  }

  tags = merge(local.common_tags, {
    Name = local.sg_web_name
  })
}

##############################################
resource "aws_security_group" "application-sg" {
  name        = format("%s-%s-app-sg", var.project, var.environment)
  description = "Application Security Group"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.cidr]
    description = "ssh"
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb-sg.id] # Referencing to ALB SG
    description     = "open to ALB APP"
  }

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.alb-sg.id] # Referencing to ALB SG
    description     = "open to ALB APP"
  }

  #Allow outgoing traffic to anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}