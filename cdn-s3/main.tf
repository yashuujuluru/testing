module "cloud_storage" {
  source              = "./modules/cloud-storage"
  bucket_name         = var.bucket_name
  backend_bucket_name = var.backend_bucket_name
  enable_cdn          = var.enable_cdn
  location            = var.location
  url_map             = var.url_map
  bucket_level_access = var.bucket_level_access

}

module "loadbalaner_cdn" {
  source                              = "./modules/loadbalaner-cdn"
  static_ip_name                      = var.static_ip_name
  static_website_forwarding_rule_name = var.static_website_forwarding_rule_name
  static_website_http_proxy_name      = var.static_website_http_proxy_name
  port_range                          = var.port_range
  url_map                             = module.cloud_storage.static-website-url_map
}