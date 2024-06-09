resource "google_storage_bucket" "static_website" {
  name                        = var.bucket_name
  location                    = var.location
  uniform_bucket_level_access = var.bucket_level_access
}

resource "google_compute_backend_bucket" "static_website_bucket" {
  name        = var.backend_bucket_name
  bucket_name = google_storage_bucket.static_website.name
  enable_cdn  = var.enable_cdn
}

resource "google_compute_url_map" "static_website_url_map" {
  name            = var.url_map
  default_service = google_compute_backend_bucket.static_website_bucket.id
}
