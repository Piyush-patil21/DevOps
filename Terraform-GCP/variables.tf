# Path to the service account JSON key file (use forward slashes on Windows too)
# variable "credentials_path" {
#   type    = string
#   default = "D:/Piyush_Desktop/Terra/rgt-data-analyst.json"
# }

# variable "auth_token" {
#   type        = string
#   description = "token"
# }

variable "project" {
  type        = string
  default = "project-ops-478805"
}

variable "region" {
  type = string
  default = "asia-south1"
  
}

#List the services you want to enabled. Service name should be as listed in GCP documentation 
variable "gcp_service_list" {
  type = list(string)
  default = [
    "compute.googleapis.com",
    "iam.googleapis.com",
    # "storage.googleapis.com",
    "secretmanager.googleapis.com"
  ]
}