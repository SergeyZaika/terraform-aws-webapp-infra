data "aws_acm_certificate" "cert" {
  provider    = aws.us_east_1
  domain   = var.cloudfront_settings.domain_name
  statuses = ["ISSUED"]
  most_recent = true
}