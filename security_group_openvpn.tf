locals {
  sg_openvpn_name = format("%s-%s-openvpn-sg", var.customer, var.environment)
}

//Bastion SG
resource "aws_security_group" "openvpn-sg" {
  name        = local.sg_openvpn_name
  description = local.sg_openvpn_name
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 1194
    to_port   = 1194
    protocol  = "udp"
    cidr_blocks = [
    "0.0.0.0/0"]
    description = "point-to-point encrypted tunnels between hosts"
  }

  ingress {
    from_port = 943
    to_port   = 943
    protocol  = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]
    description = "access web interface"
  }

  ingress {
    from_port = 945
    to_port   = 945
    protocol  = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]
    description = "connect ovpn client"
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]
    description = "ssh"
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
    protocol  = "-1" //all traffic
    cidr_blocks = [
    "0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(local.common_tags, {
    Name = local.sg_openvpn_name
  })

}