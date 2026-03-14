resource "google_service_account" "gke-sa" {
  account_id = "gke-sa"
  project    = local.project
}

resource "google_project_iam_member" "gke-logs" {
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.gke-sa.email}"
  project = local.project
}

resource "google_project_iam_member" "gke-metrics" {
  role    = "roles/monitoring.metricWriter"
  member  = "serviceAccount:${google_service_account.gke-sa.email}"
  project = local.project
}

resource "google_container_node_pool" "gke-node" {
  name    = "terra-gke-node"
  cluster = google_container_cluster.gke-cluster.name
  location = "us-central1-a"    # If we don't specify the location, it may sometime not take the cluster location by-default.

  autoscaling {     
    min_node_count = 1
    max_node_count = 3
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    machine_type    = var.machine_type
    preemptible     = false
    service_account = google_service_account.gke-sa.email
    labels = {
      name = "terra-node"
    }
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  depends_on = [ google_container_cluster.gke-cluster ]

}
