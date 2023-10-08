resource "aws_security_group" "sg_1" {
  name        = "example-security-group"
  description = "Example security group with multiple sources and ports"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["172.16.250.0/30", "172.16.251.8/30", "172.16.251.8/30", "192.168.26.0/24", "192.168.40.0/24", "192.168.98.0/23", "192.168.100.0/24", "192.168.150.0/24", "192.168.140.0/24", "192.168.80.0/24"] # Ganti dengan alamat IP yang sesuai
    description = "ssh"
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["172.16.250.0/30", "172.16.251.8/30", "172.16.251.8/30", "192.168.26.0/24", "192.168.40.0/24", "192.168.98.0/23", "192.168.100.0/24", "192.168.150.0/24", "192.168.140.0/24", "192.168.80.0/24"] # Ganti dengan alamat IP yang sesuai
    description = "icmp"

  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["172.16.250.0/30", "172.16.251.8/30", "172.16.251.8/30", "192.168.26.0/24", "192.168.40.0/24", "192.168.98.0/23", "192.168.100.0/24", "192.168.150.0/24", "192.168.140.0/24", "192.168.80.0/24"] # Ganti dengan alamat IP yang sesuai
    description = "https"
  }

  ingress {
    from_port   = 8291
    to_port     = 8291
    protocol    = "tcp"
    cidr_blocks = ["172.16.250.0/30", "172.16.251.8/30", "172.16.251.8/30", "192.168.26.0/24", "192.168.40.0/24", "192.168.98.0/23", "192.168.100.0/24", "192.168.150.0/24", "192.168.140.0/24", "192.168.80.0/24"] # Ganti dengan alamat IP yang sesuai
    description = "winbox"
  }

  ingress {
    from_port   = 8728
    to_port     = 8728
    protocol    = "tcp"
    cidr_blocks = ["172.16.250.0/30", "172.16.251.8/30", "172.16.251.8/30", "192.168.26.0/24", "192.168.40.0/24", "192.168.98.0/23", "192.168.100.0/24", "192.168.150.0/24", "192.168.140.0/24", "192.168.80.0/24"] # Ganti dengan alamat IP yang sesuai
    description = "api"
  }

  #Allow outgoing traffic to anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Contoh security group lain yang akan digunakan dalam Rule 4
resource "aws_security_group" "sg_2" {
  name        = "another-security-group"
  description = "Another example security group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["172.16.250.0/30", "172.16.251.8/30", "172.16.251.8/30", "192.168.26.0/24", "192.168.40.0/24", "192.168.98.0/23", "192.168.100.0/24", "192.168.150.0/24", "192.168.140.0/24", "192.168.80.0/24"] # Ganti dengan alamat IP yang sesuai
    description = "ssh"
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["172.16.250.0/30", "172.16.251.8/30", "172.16.251.8/30", "192.168.26.0/24", "192.168.40.0/24", "192.168.98.0/23", "192.168.100.0/24", "192.168.150.0/24", "192.168.140.0/24", "192.168.80.0/24"] # Ganti dengan alamat IP yang sesuai
    description = "icmp"

  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["172.16.250.0/30", "172.16.251.8/30", "172.16.251.8/30", "192.168.26.0/24", "192.168.40.0/24", "192.168.98.0/23", "192.168.100.0/24", "192.168.150.0/24", "192.168.140.0/24", "192.168.80.0/24"] # Ganti dengan alamat IP yang sesuai
    description = "https"
  }

  ingress {
    from_port   = 8291
    to_port     = 8291
    protocol    = "tcp"
    cidr_blocks = ["172.16.250.0/30", "172.16.251.8/30", "172.16.251.8/30", "192.168.26.0/24", "192.168.40.0/24", "192.168.98.0/23", "192.168.100.0/24", "192.168.150.0/24", "192.168.140.0/24", "192.168.80.0/24"] # Ganti dengan alamat IP yang sesuai
    description = "winbox"
  }

  ingress {
    from_port   = 2086
    to_port     = 2087
    protocol    = "tcp"
    cidr_blocks = ["172.16.250.0/30", "172.16.251.8/30", "172.16.251.8/30", "192.168.26.0/24", "192.168.40.0/24", "192.168.98.0/23", "192.168.100.0/24", "192.168.150.0/24", "192.168.140.0/24", "192.168.80.0/24"] # Ganti dengan alamat IP yang sesuai
    description = "whm"
  }

  ingress {
    from_port   = 2082
    to_port     = 2083
    protocol    = "tcp"
    cidr_blocks = ["172.16.250.0/30", "172.16.251.8/30", "172.16.251.8/30", "192.168.26.0/24", "192.168.40.0/24", "192.168.98.0/23", "192.168.100.0/24", "192.168.150.0/24", "192.168.140.0/24", "192.168.80.0/24"] # Ganti dengan alamat IP yang sesuai
    description = "cpanel"
  }

  ingress {
    from_port   = 2095
    to_port     = 2096
    protocol    = "tcp"
    cidr_blocks = ["172.16.250.0/30", "172.16.251.8/30", "172.16.251.8/30", "192.168.26.0/24", "192.168.40.0/24", "192.168.98.0/23", "192.168.100.0/24", "192.168.150.0/24", "192.168.140.0/24", "192.168.80.0/24"] # Ganti dengan alamat IP yang sesuai
    description = "webmail"
  }

  ingress {
    from_port   = 25
    to_port     = 26
    protocol    = "tcp"
    cidr_blocks = ["172.16.250.0/30", "172.16.251.8/30", "172.16.251.8/30", "192.168.26.0/24", "192.168.40.0/24", "192.168.98.0/23", "192.168.100.0/24", "192.168.150.0/24", "192.168.140.0/24", "192.168.80.0/24"] # Ganti dengan alamat IP yang sesuai
    description = "smptp"
  }

  ingress {
    from_port   = 465
    to_port     = 587
    protocol    = "tcp"
    cidr_blocks = ["172.16.250.0/30", "172.16.251.8/30", "172.16.251.8/30", "192.168.26.0/24", "192.168.40.0/24", "192.168.98.0/23", "192.168.100.0/24", "192.168.150.0/24", "192.168.140.0/24", "192.168.80.0/24"] # Ganti dengan alamat IP yang sesuai
    description = "smptp"
  }

  ingress {
    from_port   = 110
    to_port     = 995
    protocol    = "tcp"
    cidr_blocks = ["172.16.250.0/30", "172.16.251.8/30", "172.16.251.8/30", "192.168.26.0/24", "192.168.40.0/24", "192.168.98.0/23", "192.168.100.0/24", "192.168.150.0/24", "192.168.140.0/24", "192.168.80.0/24"] # Ganti dengan alamat IP yang sesuai
    description = "pop"
  }

  ingress {
    from_port   = 143
    to_port     = 993
    protocol    = "tcp"
    cidr_blocks = ["172.16.250.0/30", "172.16.251.8/30", "172.16.251.8/30", "192.168.26.0/24", "192.168.40.0/24", "192.168.98.0/23", "192.168.100.0/24", "192.168.150.0/24", "192.168.140.0/24", "192.168.80.0/24"] # Ganti dengan alamat IP yang sesuai
    description = "imap"
  }

  #Allow outgoing traffic to anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sg_all_subnet_pb" {
  name        = "another-security-group"
  description = "All subnet PB"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["172.16.250.0/30", "172.16.251.8/30", "172.16.251.8/30", "192.168.26.0/24", "192.168.40.0/24", "192.168.98.0/23", "192.168.100.0/24", "192.168.150.0/24", "192.168.140.0/24", "192.168.80.0/24"] # Ganti dengan alamat IP yang sesuai
    description = "https"
  }

  ingress {
    from_port   = 2086
    to_port     = 2087
    protocol    = "tcp"
    cidr_blocks = ["172.16.250.0/30", "172.16.251.8/30", "172.16.251.8/30", "192.168.26.0/24", "192.168.40.0/24", "192.168.98.0/23", "192.168.100.0/24", "192.168.150.0/24", "192.168.140.0/24", "192.168.80.0/24"] # Ganti dengan alamat IP yang sesuai
    description = "whm"
  }

  ingress {
    from_port   = 2082
    to_port     = 2083
    protocol    = "tcp"
    cidr_blocks = ["172.16.250.0/30", "172.16.251.8/30", "172.16.251.8/30", "192.168.26.0/24", "192.168.40.0/24", "192.168.98.0/23", "192.168.100.0/24", "192.168.150.0/24", "192.168.140.0/24", "192.168.80.0/24"] # Ganti dengan alamat IP yang sesuai
    description = "cpanel"
  }

  ingress {
    from_port   = 2095
    to_port     = 2096
    protocol    = "tcp"
    cidr_blocks = ["172.16.250.0/30", "172.16.251.8/30", "172.16.251.8/30", "192.168.26.0/24", "192.168.40.0/24", "192.168.98.0/23", "192.168.100.0/24", "192.168.150.0/24", "192.168.140.0/24", "192.168.80.0/24"] # Ganti dengan alamat IP yang sesuai
    description = "webmail"
  }

  ingress {
    from_port   = 25
    to_port     = 26
    protocol    = "tcp"
    cidr_blocks = ["172.16.250.0/30", "172.16.251.8/30", "172.16.251.8/30", "192.168.26.0/24", "192.168.40.0/24", "192.168.98.0/23", "192.168.100.0/24", "192.168.150.0/24", "192.168.140.0/24", "192.168.80.0/24"] # Ganti dengan alamat IP yang sesuai
    description = "smptp"
  }

  ingress {
    from_port   = 465
    to_port     = 587
    protocol    = "tcp"
    cidr_blocks = ["172.16.250.0/30", "172.16.251.8/30", "172.16.251.8/30", "192.168.26.0/24", "192.168.40.0/24", "192.168.98.0/23", "192.168.100.0/24", "192.168.150.0/24", "192.168.140.0/24", "192.168.80.0/24"] # Ganti dengan alamat IP yang sesuai
    description = "smptp"
  }

  ingress {
    from_port   = 110
    to_port     = 995
    protocol    = "tcp"
    cidr_blocks = ["172.16.250.0/30", "172.16.251.8/30", "172.16.251.8/30", "192.168.26.0/24", "192.168.40.0/24", "192.168.98.0/23", "192.168.100.0/24", "192.168.150.0/24", "192.168.140.0/24", "192.168.80.0/24"] # Ganti dengan alamat IP yang sesuai
    description = "pop"
  }

  ingress {
    from_port   = 143
    to_port     = 993
    protocol    = "tcp"
    cidr_blocks = ["172.16.250.0/30", "172.16.251.8/30", "172.16.251.8/30", "192.168.26.0/24", "192.168.40.0/24", "192.168.98.0/23", "192.168.100.0/24", "192.168.150.0/24", "192.168.140.0/24", "192.168.80.0/24"] # Ganti dengan alamat IP yang sesuai
    description = "imap"
  }

  #Allow outgoing traffic to anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sg_nlb_custom" {
  name        = "another-security-group"
  description = "All subnet PB"

  ingress {
    from_port   = 25
    to_port     = 26
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "smptp"
  }

  ingress {
    from_port   = 783
    to_port     = 783
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "spamassasin"
  }

  ingress {
    from_port   = 37
    to_port     = 37
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "rdate"
  }

  ingress {
    from_port   = 873
    to_port     = 873
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "rsync"
  }

  ingress {
    from_port   = 2089
    to_port     = 2089
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "cpanellicense"
  }

  #Allow outgoing traffic to anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

