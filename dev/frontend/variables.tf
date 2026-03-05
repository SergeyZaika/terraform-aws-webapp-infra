variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}
variable "env" {
  description = "Environment name"
  type        = string
  default     = "dev"
}
variable "bucket" {
  description = "An object containing the bucket configuration"
  type = object({
    bucket_name = string
    tags        = map(string)
  })
  default = {
    bucket_name = "bkt-1"
    tags = {
      "env" = "dev"
      "group"= "frontend"
    }
  }
}
  variable "cloudfront_settings" {
    type = object({
      domain_name             = string
      cf_description          = string
      origin_website_endpoint = string
      http_versions           = string
      tags = map(string)
      cache_policy_id           = string
      origin_request_policy_id  = string
      minimum_protocol_version  = string
      restriction_type          = string
      geo_restriction_locations = list(string)
      default_root_object       = string
      origin_ssl_protocols      = list(string)
      origin_read_timeout       = number
      origin_keepalive_timeout  = number
      default_cache_behavior = object({
        allowed_methods = list(string) 
        cached_methods  = list(string)
        s3_origin_id    = string
        min_ttl         = number
        default_ttl     = number
        max_ttl         = number
      }) 
    })
    default = {
      domain_name             = "example.com"
      cf_description          = "FE example description"
      origin_website_endpoint = ""
      http_versions           = "http2"
      tags = {
        env     = "dev"
        project = "example"
        group   = "frontend"
      }
      cache_policy_id           = "658327ea-f89d-4fab-a63d-7e88639e58f6" # see https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-managed-cache-policies.html#managed-cache-caching-optimized
      origin_request_policy_id  = ""
      minimum_protocol_version  = "TLSv1.2_2021"
      restriction_type          = "none"
      geo_restriction_locations = []
      default_root_object       = ""
      origin_ssl_protocols      = ["TLSv1.2", "TLSv1.1"]
      origin_read_timeout       = 30
      origin_keepalive_timeout  = 5
      default_cache_behavior = {
        allowed_methods = ["GET", "HEAD", "OPTIONS"]
        cached_methods  = ["GET", "HEAD"]
        s3_origin_id    = ""
        min_ttl         = 1
        default_ttl     = 86400
        max_ttl         = 31536000
      }
    }
  }
  