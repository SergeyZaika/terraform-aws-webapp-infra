# prod/frontend

Provisions the static frontend infrastructure for the prod environment. Creates an S3 bucket configured as a website origin and a CloudFront distribution with an ACM certificate (pre-provisioned, looked up by domain name).

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.33.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.33.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudfront_static_content"></a> [cloudfront\_static\_content](#module\_cloudfront\_static\_content) | ../modules/fe_cloudfront | n/a |
| <a name="module_frontend_bucket"></a> [frontend\_bucket](#module\_frontend\_bucket) | ../modules/fe_s3 | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.cert](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/acm_certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket"></a> [bucket](#input\_bucket) | An object containing the bucket configuration | <pre>object({<br>    bucket_name = string<br>    tags        = map(string)<br>  })</pre> | <pre>{<br>  "bucket_name": "bkt-1",<br>  "tags": {<br>    "env": "dev",<br>    "group": "frontend"<br>  }<br>}</pre> | no |
| <a name="input_cloudfront_settings"></a> [cloudfront\_settings](#input\_cloudfront\_settings) | n/a | <pre>object({<br>      domain_name             = string<br>      cf_description          = string<br>      origin_website_endpoint = string<br>      http_versions           = string<br>      tags = map(string)<br>      cache_policy_id           = string<br>      origin_request_policy_id  = string<br>      minimum_protocol_version  = string<br>      restriction_type          = string<br>      geo_restriction_locations = list(string)<br>      default_root_object       = string<br>      origin_ssl_protocols      = list(string)<br>      origin_read_timeout       = number<br>      origin_keepalive_timeout  = number<br>      default_cache_behavior = object({<br>        allowed_methods = list(string) <br>        cached_methods  = list(string)<br>        s3_origin_id    = string<br>        min_ttl         = number<br>        default_ttl     = number<br>        max_ttl         = number<br>      }) <br>    })</pre> | <pre>{<br>  "cache_policy_id": "658327ea-f89d-4fab-a63d-7e88639e58f6",<br>  "cf_description": "FE example description",<br>  "default_cache_behavior": {<br>    "allowed_methods": [<br>      "GET",<br>      "HEAD",<br>      "OPTIONS"<br>    ],<br>    "cached_methods": [<br>      "GET",<br>      "HEAD"<br>    ],<br>    "default_ttl": 86400,<br>    "max_ttl": 31536000,<br>    "min_ttl": 1,<br>    "s3_origin_id": ""<br>  },<br>  "default_root_object": "",<br>  "domain_name": "example.com",<br>  "geo_restriction_locations": [],<br>  "http_versions": "http2",<br>  "minimum_protocol_version": "TLSv1.2_2021",<br>  "origin_keepalive_timeout": 5,<br>  "origin_read_timeout": 30,<br>  "origin_request_policy_id": "",<br>  "origin_ssl_protocols": [<br>    "TLSv1.2"<br>  ],<br>  "origin_website_endpoint": "",<br>  "restriction_type": "none",<br>  "tags": {<br>    "env": "dev",<br>    "group": "frontend",<br>    "project": "example"<br>  }<br>}</pre> | no |
| <a name="input_env"></a> [env](#input\_env) | Environment name | `string` | `"dev"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"us-east-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | n/a |
| <a name="output_bucket_regional_domain_name"></a> [bucket\_regional\_domain\_name](#output\_bucket\_regional\_domain\_name) | n/a |
| <a name="output_website_endpoint"></a> [website\_endpoint](#output\_website\_endpoint) | n/a |
