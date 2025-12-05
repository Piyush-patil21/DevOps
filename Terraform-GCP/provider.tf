provider "google" {
  project                     = "project-ops-478805"
  region                      = "asia-south1"
  zone                        = "asia-south1-a"
  # impersonate_service_account = "1093939435927-compute@developer.gserviceaccount.com"
  credentials = "credentials\\key.json"
}

