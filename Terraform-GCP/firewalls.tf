resource "google_compute_firewall" "firsty-firewall" {
  name    = "terrawall"
  network = google_compute_network.firty-vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22, 80, 443, 8080"]
  }

  source_ranges = ["0.0.0.0/0"]

}