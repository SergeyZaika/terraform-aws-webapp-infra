resource "aws_s3_bucket" "this" {
  bucket = var.bucket.bucket_name
  tags   = var.bucket.tags
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.this.bucket

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

data "aws_iam_policy_document" "allow_access" {
  statement {
    sid     = "PublicReadGetObject"
    effect  = "Allow"
    actions = ["s3:GetObject"]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    resources = ["${aws_s3_bucket.this.arn}/*"]
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.allow_access.json
  depends_on = [aws_s3_bucket_public_access_block.public_access] 
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.this.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

