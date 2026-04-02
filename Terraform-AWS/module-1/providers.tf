provider "aws" {
  region = local.region
  profile = "piyush21"
  # version = ""

}

terraform {
  required_version = ">= 1.13.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.35.0"
    }
  }
}