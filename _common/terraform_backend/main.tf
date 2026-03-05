terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = "ca-central-1"    
}

module "s3_bucket" {
  source = "../modules/s3"

  bucket_name       = "terraform-state-bucket"
  enable_versioning = true
  kms_key_id        = ""
  bucket_policy = ""
  tags = {
    env     = "dev"
    project = "webapp"
    owner   = "serhii_z"
  }
  public_access = {
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  }
}