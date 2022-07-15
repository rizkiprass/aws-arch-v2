variable "aws_region" {
  description = "AWS Region"
  default     = "us-east-1"
}

variable "access_key" {
  default = ""
}

variable "aws_secret_access_key" {
  default = ""
}

// Tag
variable "Birthday" {
  default = "26-01-2022"
}

variable "Backup" {
  default = "BackupDaily"
}
variable "region" {
  default = "us-east-1"
}

variable "cidr" {
  default = "10.0.0.0/16"
}

variable "Public_Subnet_AZ1" {
  default = "10.0.0.0/24"
}

variable "Public_Subnet_AZ2" {
  default = "10.0.1.0/24"
}

variable "App_Subnet_AZ1" {
  default = "10.0.10.0/24"
}

variable "App_Subnet_AZ2" {
  default = "10.0.11.0/24"
}

variable "Data_Subnet_AZ1" {
  default = "10.0.20.0/24"
}

variable "Data_Subnet_AZ2" {
  default = "10.0.21.0/24"
}

#ami

variable "ami-ubuntu" {
  default = "ami-04505e74c0741db8d"
}

variable "ami-linux2" {
  default = "ami-0ed9277fb7eb570c9"
}

#Tagging Common
variable "environment" {
    default = "prod"
}

variable "environment_dev" {
    default = "dev"
}
variable "project" {
    default = "Sandbox"
}

locals {
  common_tags = {
    Project     = var.project
    Environment = var.environment
    Terraform   = "Yes"
  }

  common_tags_dev = {
    Project     = var.project
    Environment = var.environment_dev
    Terraform   = "Yes"
  }
}

variable "Customer" {
  default = "Sandbox"
}

#key
variable "key-bastion-inject" {
  default = "bastion-inject"
}

variable "key-sandbox-prod-app" {
  default = "key-sandbox-prod-app"
}

variable "key-sandbox-dev-app" {
  default = "key-sandbox-dev-app"
}

variable "key-sandbox-data" {
  default = "key-sandbox-data"
}

variable "key-sandbox-openvpn" {
  default = "key-sandbox-openvpn"
}