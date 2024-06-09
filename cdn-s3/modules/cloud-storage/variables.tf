variable "bucket_name" {
  type        = string
  description = "name of the cloud storage bucket name"
}

variable "location" {
  type        = string
  description = "region of the bucket"

}

variable "bucket_level_access" {
  type        = bool
  description = "for accessing the bucket"

}

variable "backend_bucket_name" {
  type        = string
  description = "name of the backend_bucket_name"

}

variable "enable_cdn" {
  type        = bool
  description = "enable the cdn for caching"

}

variable "url_map" {
  type        = string
  description = "static website url map name"
}




