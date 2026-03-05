## Examples

###  Example with custom KMS and custom S3 policy
```hcl
module "s3_bucket" {
  source = "../modules/s3"

  bucket_name       = "example-bucket"
  enable_versioning = true
  kms_key_id        = "example-kms-alias"
  bucket_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["s3:GetObject"],
        Resource = ["arn:aws:s3:::example-bucket/*"],
        Principal = {
          AWS = "arn:aws:iam::owner-id:root"
        }
      }
    ]
  })
  tags = {
    env     = "dev"
    project = "my-project"
    group   = "example"
  }
  public_access = {
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  }
}
```

###  Example without custom KMS and custom S3 policy
```hcl
module "s3_bucket" {
  source = "../modules/s3"

  bucket_name       = "example-bucket"
  enable_versioning = true
  kms_key_id        = ""
  bucket_policy = ""
  tags = {
    env     = "dev"
    project = "my-project"
    group   = "example"
  }
  public_access = {
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  }
}
```