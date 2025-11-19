resource "google_service_account" "fristy" {
  account_id   = "rgt-data-analyst"
  project = "rgt-data-analyst"
  display_name = "Compute Engine default service account"
}

resource "google_compute_instance" "fristy" {
  name         = "firstyinstance"
  machine_type = "e2-medium"
  network_interface {
    network = "default"
  }
  metadata = {
    ssh-keys = "piyush:${file("D:/Piyush_Desktop/Terra/piyush_key")}"
  }

  boot_disk {
    initialize_params {
      image = "ubuntu 24.04 LTS Minimal"
      type  = "pd-balanced"
      size  = 20
    }
  }

}