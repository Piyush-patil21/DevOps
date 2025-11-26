# terraform {
#     required_version = ">=v1.13.5 "
#   backend "gcs" {
#     bucket = "<bucket_name>"
#     prefix = "terraform/state"
#     credentials = "credentials\\<file.json>"    
#   }
#   required_providers {
#     google = {
# for small updates like from v7.11.0 to v7.11.1 we can use pessimistic constraint operator (~> 7.11.0) 
# for major upgrages like from v7.11.0 to v7.12.0 we use (>=7.11.0)
#         version = ">=7.11"
#         source = "hashicorp/google"

#     }    
#   }
# }