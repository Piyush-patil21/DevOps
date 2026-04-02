#This is new Target-group that will be craated using Jenkins script

variable "python_app_port" {}                      # port = "5000"
variable "python_app_vpc_id" {}
variable "python_app_instance_id" {}
variable "python_app_target_group_name" {}


resource "aws_lb_target_group" "python-app-target-group" {
    port = var.python_app_port
    protocol = "HTTP"       
    vpc_id = var.python_app_vpc_id
    name = var.python_app_target_group_name
    health_check {
      healthy_threshold = 4
      unhealthy_threshold = 2
      path = "/health"
      port = "5000"
      interval = "10"
    }
  
}

resource "aws_lb_target_group_attachment" "python-app-attachment" {
    target_group_arn = aws_lb_target_group.python-app-target-group.arn
    target_id        = var.python_app_instance_id
    port             = var.python_app_port
  
}

output "python_app_target_group_arn" {
  value = aws_lb_target_group.python-app-target-group.arn
  description = "The output from this block is passed to a variable in loadbalancer app"

}





# Creating Target-group infrastructure in same region as module-2 and not via Jenkins

/*
variable "alb_target_group_name" {}
variable "python_app_port" {}               # port = "5000"
variable "vpc_id" {}
variable "python_app_instance_id" {}
variable "target_group_arn" {}


resource "aws_lb_target_group" "demo-app-target-group" {
    port = var.python_app_port
    protocol = "HTTP"       
    vpc_id = var.vpc_id
    name = var.alb_target_group_name
    health_check {
      healthy_threshold = 4
      unhealthy_threshold = 2
      path = "/health"
      port = "5000"
      interval = "10"
    }
  
}


resource "aws_lb_target_group_attachment" "demo-target-group-lb-attachment" {
    target_group_arn = var.target_group_arn
    target_id = var.python_app_instance_id
    port = "8080"
  
}

output "target_group_arn" {
  value = aws_lb_target_group.demo-app-target-group.arn
  description = "The output from this block is passed to a variable in loadbalancer app"

}     */