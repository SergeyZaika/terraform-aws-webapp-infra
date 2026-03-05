terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

data "aws_acm_certificate" "cert" {
  domain   = var.cloudfront_settings.domain_name
  statuses = ["ISSUED"]
  most_recent = true
}

resource "aws_cloudfront_distribution" "cdn" {
  origin {
    domain_name = var.cloudfront_settings.origin_website_endpoint
    origin_id   = var.cloudfront_settings.default_cache_behavior.s3_origin_id

    custom_origin_config {
      http_port                = 80
      https_port               = 443
      origin_protocol_policy   = "http-only"
      origin_ssl_protocols     = var.cloudfront_settings.origin_ssl_protocols
      origin_read_timeout      = var.cloudfront_settings.origin_read_timeout
      origin_keepalive_timeout = var.cloudfront_settings.origin_keepalive_timeout
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = var.cloudfront_settings.cf_description
  default_root_object = var.cloudfront_settings.default_root_object

  aliases = var.cloudfront_settings.domain_name != "" ? [var.cloudfront_settings.domain_name] : []

  default_cache_behavior {
    allowed_methods        = var.cloudfront_settings.default_cache_behavior.allowed_methods
    cached_methods         = var.cloudfront_settings.default_cache_behavior.cached_methods
    target_origin_id       = var.cloudfront_settings.default_cache_behavior.s3_origin_id
    cache_policy_id        = var.cloudfront_settings.cache_policy_id

    origin_request_policy_id = var.cloudfront_settings.origin_request_policy_id != "" ? var.cloudfront_settings.origin_request_policy_id : null

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = var.cloudfront_settings.default_cache_behavior.min_ttl
    default_ttl            = var.cloudfront_settings.default_cache_behavior.default_ttl
    max_ttl                = var.cloudfront_settings.default_cache_behavior.max_ttl
  }

  restrictions {
    geo_restriction {
      restriction_type = var.cloudfront_settings.restriction_type
      locations        = var.cloudfront_settings.geo_restriction_locations
    }
  }

  viewer_certificate {
    acm_certificate_arn            = data.aws_acm_certificate.cert.arn
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = var.cloudfront_settings.minimum_protocol_version
    cloudfront_default_certificate = false
  }

  http_version = var.cloudfront_settings.http_versions

  tags = var.cloudfront_settings.tags
}
