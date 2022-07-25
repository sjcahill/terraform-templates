terraform {
  cloud {
    organization = "sjoss-info"

    workspaces {
      name = "sj-dev-apogee-testing"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "power_bi_ami_bucket" {
  bucket = "sj-apogee-powerbi-ami"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket" "dev_bucket" {
  bucket = "dev-sj-apogee-test"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket" "prod_bucket" {
  bucket = "prod-sj-apogee-test"

  lifecycle {
    prevent_destroy = true
  }
}



resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.power_bi_ami_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.power_bi_ami_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.power_bi_ami_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
