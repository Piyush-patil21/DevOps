provider "google" {
  project = local.project
  region  = local.region
  # zone    = var.zone

  # impersonate_service_account = "1093939435927-compute@developer.gserviceaccount.com"
  # credentials = "credentials\\key.json"
}

terraform {
  required_version = ">=1.12.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.0"
    }
  }

}