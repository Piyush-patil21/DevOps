resource "google_compute_firewall" "firsty-firewall" {
  name    = "terrawall"
  network = google_compute_network.firsty-vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22", "443"]

  }

  source_ranges = ["0.0.0.0/0"]

}