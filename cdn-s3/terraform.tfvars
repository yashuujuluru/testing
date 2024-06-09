location                            = "us-east1"
bucket_name                         = "cdn-test-bucket12"
backend_bucket_name                 = "static-website-backend-bucket"
enable_cdn                          = true
url_map                             = "static-website-url-map"
bucket_level_access                 = true
static_ip_name                      = "static-website-ip"
static_website_forwarding_rule_name = "static-website-forwarding-rule"
static_website_http_proxy_name      = "static-website-http-proxy"
port_range                          = "80"

