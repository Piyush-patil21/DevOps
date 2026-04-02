variable "vpc_cidr" {
  type        = string
  description = "VPC cidr range for my virtual private network"

}

variable "vpc_name" {
  type        = string
  description = "Name for VPC"

}

variable "vpc_public_cidr" {
  type        = list(string)
  description = "public subnet CIDR"

}

variable "vpc_private_cidr" {
  type        = list(string)
  description = "private subnet CIDR"

}

variable "av_zone1" {
  type        = list(string)
  description = "availability zone 1"

}

variable "sg_name" {
  type        = string
  description = "Name of the security group required for Jenkins server"

}

variable "ami_id" {
  type        = string
  description = "AMI ID for Jenkins server"

}

variable "public_key_name" {
  type        = string
  description = "Public key for SSH access to Jenkins server"

}

# variable "instance_type" {
#   type        = string
#   description = "Instance type for Jenkins server"

# }

# Variables for Python App Setup Infrastructure configuration

variable "python_app_sg_name" {
  type        = string
  description = "Name of the security group required for Python application server"
}

variable "python_app_basic_sg_name" {
  type        = string
  description = "Name of the basic security group required for Python application server"
}

variable "mysql_sg_name" {
  type        = string
  description = "Name of the security group required for MySQL server"

}

variable "python_app_public_cidr" {
  type        = list(string)
  description = "python app public subnet CIDR"

}

variable "python_app_private_cidr" {
  type        = list(string)
  description = "python app private subnet CIDR"

}

variable "python_app_vpc_name" {
  type        = string
  description = "Name for Python application VPC"
}

variable "python_app_vpc_cidr" {
  type        = string
  description = "VPC cidr range for Python application virtual private network"

}

variable "python_app_av_zone1" {
  type        = list(string)
  description = "availability zone for Python application"

}

variable "python_app_domain_name" {
  type        = string
  description = "Domain name for Python application"

}