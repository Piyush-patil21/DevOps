provider "aws" {
  # profile = "piyush21"
  # region  = "ap-south-1"
  region = "us-east-1"
  # version = ""

}

terraform {
  required_version = ">= 1.12.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.35.0"
    }
  }
}

