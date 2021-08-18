provider "aws" {
    region = "eu-west-1"
    shared_credentials_file = "/home/mehmet/.aws/credentials"
}

terraform {
  required_providers {
    archive = "~> 1.3"
  }
}