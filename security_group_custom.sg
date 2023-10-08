variable "application-port-list" {
  type = map(any)
  default = {
    "http"  = 80
    "https" = 443
    "ssh"   = 22
  }
}

variable "application-port-list2" {
  type = map(any)
  default = {
    "http"  = 880
    "https" = 4432
    "ssh"   = 223
  }
}

//Prod-App-sg
resource "aws_security_group" "web-app-sg" {
  name        = "tset"
  description = "test"
  vpc_id      = "vpc-0511ffde27511ff09"

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

    dynamic "ingress" {
    for_each = var.application-port-list2
    content {
      from_port = ingress.value
      to_port   = ingress.value
      protocol  = "tcp"
      cidr_blocks = [
      "10.1.0.0/16", "10.2.0.0/16"]
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
  })
}