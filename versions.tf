terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Remote state in S3 with DynamoDB locking.
  # Backend blocks cannot use variables, so the values are written directly.
  backend "s3" {
    bucket         = "my-terraform-state-bucket-12-345"
    key            = "eks/my-eks/terraform.tfstate"
    region         = "ap-south-1" # must be the region the bucket was created in
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project     = var.cluster_name
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  }
}
