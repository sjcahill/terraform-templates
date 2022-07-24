terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      # ~> indicates that only the righmost version component can increment. In this case minor
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket         = "<YOUR S3 BUCKET>"
    key            = "<SOME PATH>/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "<YOUR DYNAMODB TABLE>"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_db_instance" "mysql-db" {
  identifier_prefix = "sj-terraform-up-and-runngin"
  engine            = "mysql"

  # Storage size in GB
  allocated_storage   = 10
  instance_class      = "db.t2.micro"
  skip_final_snapshot = true
  db_name             = "mysql-dev"

  username = var.mysql_username
  password = var.mysql_password
}
