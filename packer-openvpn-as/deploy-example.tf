resource "aws_instance" "openvpn-as" {
  ami = "ami-openvpn-packer"
  instance_type = "t3a.micro"
  # Required
  source_dest_check = false

}
# Associate Elastic IP With OpenVPN Instance
resource "aws_eip" "openvpn-as-eip" {
  instance = aws_instance.openvpn-as.id
  tags = {}
}

/*
resource "aws_route" "openvpn-as-eip" {
  route_table_id            = "rtb-4fbb3ac4"
  destination_cidr_block    = "172.240.0.0/20" # OpenVPN AS Internal Pool IP for VPN Client
  instance_id = aws_instance.openvpn-as.id
}
*/
