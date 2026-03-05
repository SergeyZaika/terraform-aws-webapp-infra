
### region = "ca-central-1"  #don't using
env = "dev"
bucket = {
  description = "An object containing the bucket configuration"
  bucket_name = "webapp-frontend-dev"
    tags = {
      "env" = "dev"
      "group"= "frontend"
    }
  }

cloudfront_settings = {
   
      domain_name             = "example.com"  #The certificate and domain is pre-created manually, meaning we are using a previously created certificate and domain.
      cf_description          = "FE example description"
      origin_website_endpoint = "module.frontend_bucket.website_endpoint"
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
  
  