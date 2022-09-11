provider "aws" {
  region     = "us-east-1"
  profile = "mnc-portal-prod-us"

}

terraform {
  backend "s3" {
    bucket = "ics-provision-us"
    key = "TF/mnc-portal-ai-ml-cdn.tfstate" # FOLDER/name.tfstate
    region = "us-east-1"
    profile = "mnc-portal-prod-us"
  }
  required_providers {
    aws = {
      version = ">= 2.7.0"
      source = "hashicorp/aws"
    }
  }
}

