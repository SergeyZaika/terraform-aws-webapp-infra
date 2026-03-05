<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudfront_distribution.cdn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_acm_certificate.cert](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/acm_certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudfront_settings"></a> [cloudfront\_settings](#input\_cloudfront\_settings) | Settings for the CloudFront distribution | <pre>object({<br>    domain_name             = string<br>    cf_description          = string<br>    origin_website_endpoint = string<br>    http_versions           = string<br>    tags                    = map(string)<br>    cache_policy_id         = string<br>    origin_request_policy_id = string<br>    minimum_protocol_version = string<br>    restriction_type        = string<br>    geo_restriction_locations = list(string)<br>    default_root_object     = string<br>    origin_ssl_protocols    = list(string)<br>    origin_read_timeout     = number<br>    origin_keepalive_timeout = number<br>    default_cache_behavior = object({<br>      allowed_methods = list(string)<br>      cached_methods  = list(string)<br>      s3_origin_id    = string<br>      min_ttl         = number<br>      default_ttl     = number<br>      max_ttl         = number<br>    })<br>  })</pre> | <pre>{<br>  "cache_policy_id": "658327ea-f89d-4fab-a63d-7e88639e58f6",<br>  "cf_description": "FE example Cloudfront",<br>  "default_cache_behavior": {<br>    "allowed_methods": [<br>      "GET",<br>      "HEAD"<br>    ],<br>    "cached_methods": [<br>      "GET",<br>      "HEAD"<br>    ],<br>    "default_ttl": 86400,<br>    "max_ttl": 31536000,<br>    "min_ttl": 1,<br>    "s3_origin_id": "s3-origin"<br>  },<br>  "default_root_object": "",<br>  "domain_name": "",<br>  "geo_restriction_locations": [],<br>  "http_versions": "http2",<br>  "minimum_protocol_version": "TLSv1.2_2021",<br>  "origin_keepalive_timeout": 5,<br>  "origin_read_timeout": 30,<br>  "origin_request_policy_id": "",<br>  "origin_ssl_protocols": [<br>    "TLSv1.2",<br>    "TLSv1.1"<br>  ],<br>  "origin_website_endpoint": "",<br>  "restriction_type": "none",<br>  "tags": {}<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudfront_distribution_id"></a> [cloudfront\_distribution\_id](#output\_cloudfront\_distribution\_id) | n/a |
| <a name="output_cloudfront_domain_name"></a> [cloudfront\_domain\_name](#output\_cloudfront\_domain\_name) | n/a |
<!-- END_TF_DOCS -->