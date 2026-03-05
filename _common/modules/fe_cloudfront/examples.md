## Examples

### Example: Front-End Bucket with CloudFront and Alternate Domain

Please note that the [module](./main.tf#L1) currently uses a data source to obtain an already issued ACM certificate for the alternate domain. Therefore, you need to create the ACM certificate beforehand.

```txt
data "aws_acm_certificate" "cert" {
  domain   = var.cloudfront_settings.domain_name
  statuses = ["ISSUED"]
  most_recent = true
}
```


```hcl
module "cloudfront_static_content" {
  source = "../modules/fe_cloudfront"

  cloudfront_settings = {
    domain_name             = "example.com"
    cf_description          = "FE example description"
    origin_website_endpoint = module.frontend_bucket.website_endpoint
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
      s3_origin_id    = module.frontend_bucket.bucket_name
      min_ttl         = 1
      default_ttl     = 86400
      max_ttl         = 31536000
    }
  }
  depends_on = [ module.frontend_bucket ]
}

module "frontend_bucket" {
  source = "../modules/fe_s3"

  bucket = {
    bucket_name = "example-bkt"
    tags = {
      env   = "dev"
      group = "frontend"
    }
  }
}
```
