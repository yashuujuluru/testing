output "load_balancer_ip" {
  value = google_compute_global_address.static_website_ip.address
}

output "static-ip-address" {
  value = google_compute_global_address.static_website_ip.address

}