locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}
# source blocks configure your builder plugins; your source is then used inside
# build blocks to create resources. A build block runs provisioners and
# post-processors on an instance created by the source.
source "amazon-ebs" "openvpn-as" {
  access_key = var.AWS-ACCESS-KEY
  secret_key = var.AWS-SECRET-KEY
  ami_name = "OpenVPN Access Server - Build Date ${local.timestamp}"
  instance_type = "t3.micro"
  region = var.region
  source_ami_filter {
    filters = {
      name = "ubuntu/images/*ubuntu-bionic-18.04-amd64-server-*"
      root-device-type = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners = [
      "099720109477"]
  }
  ssh_username = "ubuntu"
}

# a build block invokes sources and runs provisioning steps on them.
build {
  sources = [
    "source.amazon-ebs.openvpn-as"]
  provisioner "file"  {
    destination = "/tmp/"
    source      = "./ubuntu18-openvpn-as-repo.list"
  }

  provisioner "shell" {
    inline = [
      "sleep 30",
      "sudo apt update",
      "sudo apt -y install ca-certificates wget net-tools gnupg",
      "wget -qO - https://as-repository.openvpn.net/as-repo-public.gpg | sudo apt-key add -",
      "sudo mv /tmp/ubuntu18-openvpn-as-repo.list /etc/apt/sources.list.d/openvpn-as-repo.list",
      "sudo apt update",
      "sudo apt -y install openvpn-as"]
  }
}

#To reconfigure manually, use the /usr/local/openvpn_as/bin/ovpn-init tool