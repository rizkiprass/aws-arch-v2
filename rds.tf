resource random_string "dbpass" {
  length  = 16
  upper   = true
  lower   = true
  number  = true
  special = false
}

resource "aws_db_parameter_group" "rdsmysql-pg" {
  name   = "rdsmysql-pg"
  family = "mysql5.7"
  description = "mysql-db"
}

resource "aws_db_subnet_group" "subnetgroup_db" {
  name       = "rdsmysql"
  #subnet_ids = ["${aws_subnet.subnet-db-1a.id}", "${aws_subnet.subnet-db-1b.id}"]
  subnet_ids =   [module.vpc.intra_subnets[0], module.vpc.intra_subnets[0]]

  tags = {
    Name = "rdsmysql"
    Birthday = "${var.Birthday}"
    Environment = "${var.environment == "" ? "Development" : "Production"}"
  }
}

resource "aws_security_group" "rds_sg" {
    name = "rdsmysql"
    description = "rdsmysql"
    vpc_id      = module.vpc.vpc_id

    ingress {
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        cidr_blocks = [var.cidr]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
// RDS
resource "aws_db_instance" "rdsmysql" {
  allocated_storage       = 80
  storage_type            = "gp2"
  engine                  = "mysql"
  engine_version          = "5.7.38"
  instance_class          = "db.t3.medium"
  name                    = "rdsmysql"
  identifier              = "rdsmysql"
  username                = "admin"
  password                = random_string.dbpass.result
  port                    = "3306"
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.subnetgroup_db.id
  deletion_protection     = false
  backup_retention_period = 30
  maintenance_window      = "Mon:00:00-Mon:03:00"
  backup_window           = "03:00-06:00"
#  ca_cert_identifier      = "rds-ca-2019"
  auto_minor_version_upgrade  = "true"
  parameter_group_name    = aws_db_parameter_group.rdsmysql-pg.id
  multi_az                = true

  skip_final_snapshot = true
  publicly_accessible = false

  tags = {
    Name = "rdsmysql"
    Birthday = "${var.Birthday}"
    Environment = "${var.environment == "" ? "Development" : "Production"}"
  }
}

output dbpass {
  value       = "Please copy and save your password = ${random_string.dbpass.result}"
  description = "password rds"
}