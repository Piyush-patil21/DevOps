# Path to the service account JSON key file (use forward slashes on Windows too)
variable "credentials_path" {
  type    = string
  default = "D:/Piyush_Desktop/Terra/rgt-data-analyst.json"
}

variable "auth_token" {
  type        = string
  description = "token"
}