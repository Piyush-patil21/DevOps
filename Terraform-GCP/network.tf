resource "google_compute_network" "firty-vpc" {
  name                            = "terravpc"
  auto_create_subnetworks         = false
  mtu                             = "1460"
  routing_mode                    = "GLOBAL"
  delete_default_routes_on_create = false
  depends_on                      = [google_project_service.gcp_services]
}

resource "google_compute_route" "firsty-route" {
  name             = "terraroute"
  dest_range       = "0.0.0.0/0"
  network          = google_compute_network.firty-vpc.name
  next_hop_gateway = "default-internet-gateway"
}

resource "google_compute_subnetwork" "firsty-public-sub" {
  name                     = "terra-publicsub"
  ip_cidr_range            = "10.10.0.0/20"
  region                   = "asia-south1"
  network                  = google_compute_network.firty-vpc.name
  private_ip_google_access = true
  stack_type               = "IPV4_ONLY"
}

resource "google_compute_subnetwork" "firsty-private-sub" {
  name                     = "terra-privatesub"
  ip_cidr_range            = "10.0.16.0/20"
  region                   = "asia-south1"
  network                  = google_compute_network.firty-vpc.name
  private_ip_google_access = true
  stack_type               = "IPV4_ONLY"

  secondary_ip_range {
    range_name    = "k8s-pods"
    ip_cidr_range = "172.16.0.0/24"
  }
}

resource "google_compute_address" "firsty-nat" {
  name = "nat"
  # subnetwork = "google_compute_subnetwork.firsty-private-sub.name"
  # address = ""
  address_type = "EXTERNAL"
  depends_on   = [google_project_service.gcp_services]
}

resource "google_compute_router" "firsty-router" {
  name    = "terra-router"
  region  = "asia-south1"
  network = "google_compute_network.firty-vpc.name"
}

resource "google_compute_router_nat" "nat" {
  name                               = "terra-nat"
  region                             = "asia-south1"
  router                             = "google_compute_router.firsty-router.name"
  nat_ip_allocate_option             = "MANUAL_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  nat_ips                            = [google_compute_address.firsty-nat.self_link]
  subnetwork {
    name                    = google_compute_subnetwork.firsty-private-sub.self_link
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}