variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
  default     = "graphite-lamp-421814"
}

variable "region" {
  description = "The region where resources will be created"
  type        = string
  default     = "us-central1"
}
