# resource "google_service_account" "fristysa" {
#   account_id   = "<project-id>"
#   project      = local.project
#   display_name = "Compute Engine default service account"
# }

# I can use random_shuffle resource to randomly select an availability zone from the list of availability zones in the region. 
# This will help in distributing the instances across different availability zones and improve the availability of the application.


# resource "random_shuffle" "random_az" {
#   input        = ["us-central1-a", "us-central1-b", "us-central1-c"]
#   result_count = 1
# }

# resource "google_compute_instance" "fristy-instance" {
#   name         = "terrainstance"
#   machine_type = "e2-medium"
#   zone         = random_shuffle.random_az.result[0] # Picks one random availability zone from the random_shuffle list
#   tags         = ["devops"]
#   network_interface {
#     network = "default"
#   }
#   metadata = {
#     ssh-keys = "ubuntu:${file("./credentials/gcp_key.pub")}"
#   }

#   boot_disk {
#     initialize_params {
#       image = "ubuntu 24.04 LTS Minimal"
#       type  = "pd-balanced"
#       size  = 20
#     }
#   }

#   depends_on = [google_project_service.gcp_services]

# }
