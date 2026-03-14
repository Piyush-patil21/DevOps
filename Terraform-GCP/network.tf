resource "google_compute_network" "firsty-vpc" {
  name                            = "terravpc"
  auto_create_subnetworks         = false
  mtu                             = "1460"
  routing_mode                    = "REGIONAL"
  delete_default_routes_on_create = false
  depends_on                      = [google_project_service.gcp_services]
}

resource "google_compute_route" "firsty-route" {
  name             = "terraroute"
  dest_range       = "0.0.0.0/0"
  network          = google_compute_network.firsty-vpc.name
  next_hop_gateway = "default-internet-gateway"
}

resource "google_compute_subnetwork" "firsty-public-sub" {
  name                     = "terra-publicsub"
  ip_cidr_range            = "10.10.0.0/20"
  region                   = local.region
  network                  = google_compute_network.firsty-vpc.name
  private_ip_google_access = true
  stack_type               = "IPV4_ONLY"
}

resource "google_compute_subnetwork" "firsty-private-sub" {
  name                     = "terra-privatesub"
  ip_cidr_range            = "10.0.16.0/20"
  region                   = local.region
  network                  = google_compute_network.firsty-vpc.name
  private_ip_google_access = true
  stack_type               = "IPV4_ONLY"

  secondary_ip_range {
    range_name    = "k8s-pods"
    ip_cidr_range = "172.16.0.0/21" # Total 2048 IPs for pods (Range:- 172.16.0.0 - 172.16.7.255)
  }

  secondary_ip_range {
    range_name    = "k8s-services"
    ip_cidr_range = "172.18.0.0/24" # Total 256 IPs for services (Range:- 172.18.0.0 - 172.18.0.255)
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
  region  = local.region
  network = google_compute_network.firsty-vpc.name
}

resource "google_compute_router_nat" "nat" {
  name                               = "terra-nat"
  region                             = local.region
  router                             = google_compute_router.firsty-router.name
  nat_ip_allocate_option             = "MANUAL_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  nat_ips                            = [google_compute_address.firsty-nat.self_link]
  subnetwork {
    name                    = google_compute_subnetwork.firsty-private-sub.self_link
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}