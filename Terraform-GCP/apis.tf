# Old method-1
# resource "google_project_service" "gcp_services" {
#     count = length(var.gcp_service_list)
#     project = "var.project"
#     service = var.gcp_service_list[count.index]
#     disable_on_destroy = false
#     disable_dependent_services = true
# }

# Method-2
# Manually enable the service api's one-by-one. 

# resource "google_project_service" "compute_api" {
#   project = var.project
#   service = "compute.googleapis.com"
#   disable_on_destroy = false
# }

# Sorted method
# Method-3
# Enable each service in gcp_service_list. for_each gives a resource per service.
# We add depends_on so Terraform enables serviceusage.googleapis.com first.
resource "google_project_service" "gcp_services" {
  for_each = toset(var.gcp_service_list)
  project  = var.project_id
  service  = each.value

  disable_dependent_services = true

  # ensure serviceusage is on before trying to enable others
  #   depends_on = [google_project_service.serviceusage]
}

# for_each function in terraform only works for object so if we have array we can convert that array into object by 
# using toset function. toset will convert list into set and set is a collection of unique values and it can be used with for_each.
