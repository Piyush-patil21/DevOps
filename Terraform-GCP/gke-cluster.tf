resource "google_container_cluster" "gke-cluster" {
  name     = "terra-gke-cluster"
  location = "us-central1-a"
  # We can't create a cluster with no node pool defined, but we want to only use separately managed node pools.
  remove_default_node_pool = true # So we create the smallest possible default node pool and immediately delete it.   
  initial_node_count       = 1

  network    = google_compute_network.firsty-vpc.self_link
  subnetwork = google_compute_subnetwork.firsty-private-sub.self_link

  # when we want to assign IP addresses to pods and services from secondary ranges, than we use VPC-NATIVE, 
  # In VPC-NATIVE clusters, we need to specify the secondary range names in the ip_allocation_policy block.
  networking_mode     = "VPC_NATIVE"

  # Allows the cluster to be deleted without additional confirmation. 
  # This is useful for development and testing environments where you may want to frequently create and destroy clusters.
  deletion_protection = false 

  # Optional, if you want multi-zonal cluster
  # node_locations = ["us-central1-b"]

  node_config {
    machine_type = "e2-medium"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  # Enable the Kubernetes Dashboard add-on
  addons_config {
    horizontal_pod_autoscaling {
      disabled = false
    }
    http_load_balancing {
      disabled = true
    }
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "k8s-pods"
    services_secondary_range_name = "k8s-services"
  }

  # The release channel determines the version of Kubernetes that will be used for the cluster. This feature provides more
  # control over automatic updates and allows you to choose a specific release channel.

  # STABLE: Production users who need stability and predictability. This channel receives updates after they have been tested.
  # REGULAR: Users who want to stay up-to-date with the latest features and improvements. This channel receives updates more frequently than STABLE.
  # RAPID: Early adopters who want to access new features and improvements. Most suitable for testers and developers.
  release_channel {
    channel = "STABLE"
  }

  workload_identity_config {
    workload_pool = "${local.project}.svc.id.goog"
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "192.168.0.0/28"
  }

}
