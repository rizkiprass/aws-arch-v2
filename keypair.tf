//# Generates RSA Keypair
//resource "tls_private_key" "webserver_key" {
//  algorithm = "RSA"
//  rsa_bits  = 4096
//}
//
//# Save Private key locally
//resource "local_file" "private_key" {
//  depends_on = [
//    tls_private_key.webserver_key,
//  ]
//  content  = tls_private_key.webserver_key.private_key_pem
//  filename = "webserver.pem"
//}
//
//# Upload public key to create keypair on AWS
//resource "aws_key_pair" "webserver_key" {
//  depends_on = [
//    tls_private_key.webserver_key,
//  ]
//  key_name   = "webserver"
//  public_key = tls_private_key.webserver_key.public_key_openssh
//}

resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "webmaster-key" {
  key_name   = "webmaster-key" # Create "myKey" to AWS!!
  public_key = tls_private_key.pk.public_key_openssh

  provisioner "local-exec" { # Create "myKey.pem" to your computer!!
    command = "echo '${tls_private_key.pk.private_key_pem}' > ./webmaster-key.pem"
  }
}

resource "aws_key_pair" "bastion-key" {
  key_name   = "bastion-key" # Create "myKey" to AWS!!
  public_key = tls_private_key.pk.public_key_openssh

  provisioner "local-exec" { # Create "myKey.pem" to your computer!!
    command = "echo '${tls_private_key.pk.private_key_pem}' > ./bastion-key.pem"
  }
}