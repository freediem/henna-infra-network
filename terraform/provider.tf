terraform {
  required_version = ">= 1.1.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.11.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Terraform = "True"
      Org = "ssg-dept-${var.environment}"
      Manager = "ToBeChanged"
    }
  }
}
