resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  tags = var.tags
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = var.public_access.block_public_acls
  block_public_policy     = var.public_access.block_public_policy
  ignore_public_acls      = var.public_access.ignore_public_acls
  restrict_public_buckets = var.public_access.restrict_public_buckets
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = var.kms_key_id != "" ? var.kms_key_id : null
    }
  }
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = var.bucket_policy
  count  = var.bucket_policy != "" ? 1 : 0
}
