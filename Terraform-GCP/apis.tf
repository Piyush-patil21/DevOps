# Old method-1
# resource "google_project_service" "compute" {
#     count = length(var.gcp_service_list)
#     project = "var.project"
#     service = var.gcp_service_list[count.index]
#     disable_on_destroy = false
#     disable_dependent_services = true
# }


# Method-2
# Enable each service in gcp_service_list. for_each gives a resource per service.
# We add depends_on so Terraform enables serviceusage.googleapis.com first.
resource "google_project_service" "gcp_services" {
  for_each = toset(var.gcp_service_list)
  project  = var.project
  service  = each.value

  disable_dependent_services = true

  # ensure serviceusage is on before trying to enable others
  #   depends_on = [google_project_service.serviceusage]
}