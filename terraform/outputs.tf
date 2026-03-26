output "frontend_url" {
  value = module.s3.website_url
}

output "api-gw-url" {
  value = module.api-gateway.api_gw_url
}