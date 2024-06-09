output "bucket_url" {
  value = google_storage_bucket.static_website.url
}

output "static-website-url_map" {
  value = google_compute_url_map.static_website_url_map.id

}

output "backend-buck-id" {
  value = google_compute_backend_bucket.static_website_bucket.id

}