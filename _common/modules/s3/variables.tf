variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "enable_versioning" {
  description = "Enable versioning for the S3 bucket"
  type        = bool
  default     = false
}

variable "kms_key_id" {
  description = "The KMS key ID to use for server-side encryption. Defaults to the AWS managed key 'aws:kms'"
  type        = string
  default     = ""
}

variable "bucket_policy" {
  description = "The JSON policy to apply to the S3 bucket"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to assign to the bucket"
  type        = map(string)
  default     = {}
}

variable "public_access" {
  description = "Configuration for blocking public access"
  type = object({
    block_public_acls       = bool
    block_public_policy     = bool
    ignore_public_acls      = bool
    restrict_public_buckets = bool
  })
  default = {
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  }
}