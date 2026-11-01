terraform {
  required_version = ">= 1.11.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Remote state in S3 with S3-native locking (use_lockfile).
  # Backend blocks cannot use variables, so the values are written directly.
  # The backend region is the region of the BUCKET and is independent of the
  # region the EKS cluster is created in (var.region).
  backend "s3" {
    bucket       = "my-terraform-state-bucket-12-345"
    key          = "eks/my-eks/terraform.tfstate"
    region       = "ap-southeast-2" # region where the bucket was created
    use_lockfile = true
    encrypt      = true
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
