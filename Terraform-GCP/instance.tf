# resource "google_service_account" "fristysa" {
#   account_id   = "project-ops-478805"
#   project      = var.project
#   display_name = "Compute Engine default service account"
# }

# resource "google_compute_instance" "fristy-instance" {
#   name         = "terrainstance"
#   machine_type = "e2-medium"
#   # zone = "asia-south1-b"
#   # tags = [ "devops" ]
#   network_interface {
#     network = "default"
#   }
#   metadata = {
#     ssh-keys = "piyush:${file("D:/Piyush_Desktop/Terra/piyush_key")}"
#   }

#   boot_disk {
#     initialize_params {
#       image = "ubuntu 24.04 LTS Minimal"
#       type  = "pd-balanced"
#       size  = 20
#     }
#   }

# }