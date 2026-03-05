output "bucket_name" {
  value = module.frontend_bucket.bucket_name
}
output "bucket_regional_domain_name" {
  value = module.frontend_bucket.bucket_regional_domain_name  
}
output "website_endpoint" {
  value = module.frontend_bucket.website_endpoint
}