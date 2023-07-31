variable "aws_region" {
  description = "AWS Region"
  default     = "us-west-2"
}

variable "access_key" {}

variable "secret_key" {}

################# CIDR ##################
variable "cidr" {
  default = "30.0.0.0/16"
}

variable "cidr2" {
  default = "30.1.0.0/16"
}

variable "Public_Subnet_AZA_1" {
  default = "30.0.0.0/24"
}
variable "Public_Subnet_AZA_2" {
  default = "30.0.1.0/24"
}

variable "Public_Subnet_AZB_1" {
  default = "30.0.2.0/24"
}

variable "Public_Subnet_AZB_2" {
  default = "30.0.3.0/24"
}

variable "App_Subnet_AZA" {
  default = "30.0.10.0/24"
}

variable "App_Subnet_AZB" {
  default = "30.0.11.0/24"
}

variable "Data_Subnet_AZA" {
  default = "30.0.20.0/24"
}

variable "Data_Subnet_AZB" {
  default = "30.0.21.0/24"
}

############################# TAG ##################################

variable "Birthday" {
  default = "26-01-2022"
}

variable "Backup" {
  default = "BackupDaily"
}
variable "region" {
  default = "us-west-2"
}

#Tagging Common
variable "environment" {
  default = "prod"
}

variable "environment_dev" {
  default = "dev"
}

variable "project" {
  default = "sandbox"
}

variable "customer" {
  default = "sandbox"
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

#key
variable "key-bastion-inject" {
  default = "bastion-inject"
}
