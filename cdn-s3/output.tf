output "load_balancer_ip" {
  value = module.loadbalaner_cdn
}

output "static-ip-address" {
  value = module.loadbalaner_cdn

}

output "bucket_url" {
  value = module.cloud_storage
}

output "static-website-url_map" {
  value = module.cloud_storage

}

output "backend-buck-id" {
  value = module.cloud_storage

}