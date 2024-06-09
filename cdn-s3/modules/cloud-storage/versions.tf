terraform {
  required_version = ">= 1.5"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.16.0"
    }

    external = {
      source  = "external"
      version = ">= 2.3.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 3.0.0" # Specify the version constraint for the TLS provider
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.1.0" # Specify the version constraint for the local provider
    }
  }
}