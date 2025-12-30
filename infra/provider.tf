terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.25.0"
    }
  }

  backend "s3" {
    bucket         = "hasanenv-tf-state"
    key            = "terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "terraform-state-lock"
  }
}

provider "aws" {
  region = "eu-west-2"
}
