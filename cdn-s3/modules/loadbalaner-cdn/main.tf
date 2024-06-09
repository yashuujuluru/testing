resource "google_compute_global_address" "static_website_ip" {
  name = var.static_ip_name
}


resource "google_compute_target_http_proxy" "static_website_http_proxy" {
  name    = var.static_website_http_proxy_name
  url_map = var.url_map # google_compute_url_map.static_website_url_map.id
}

resource "google_compute_global_forwarding_rule" "static_website_forwarding_rule" {
  name       = var.static_website_forwarding_rule_name
  target     = google_compute_target_http_proxy.static_website_http_proxy.id
  port_range = var.port_range
  ip_address = google_compute_global_address.static_website_ip.address
}