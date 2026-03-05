module "frontend_bucket" {
  source = "../../_common/modules/fe_s3"
  bucket = var.bucket
}

module "cloudfront_static_content" {
  source = "../../_common/modules/fe_cloudfront"

  cloudfront_settings = merge(
    var.cloudfront_settings,
    {
      origin_website_endpoint = module.frontend_bucket.website_endpoint,
      default_cache_behavior = merge(
        var.cloudfront_settings.default_cache_behavior,
        {
          s3_origin_id = module.frontend_bucket.bucket_name
        }
      )
    }
  )

  providers = {
    aws = aws.us_east_1
  }

  depends_on = [
    module.frontend_bucket
  ]
}

