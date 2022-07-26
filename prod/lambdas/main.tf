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

