#This is new Load-balancer that will be craated using Jenkins script

variable "target_group_arn" {}
variable "python_app_lb_name" {}
variable "lb_security_group" {}
variable "lb_subnet_id" {}
variable "ssl_policy_for_lb" {} 
variable "certificate_arn" {}
variable "python_app_instance_id" {}


resource "aws_lb" "python-app-lb" {
    name = var.python_app_lb_name
    internal = false
    load_balancer_type = "application"
    security_groups = [var.lb_security_group] 
    enable_deletion_protection = false
    subnets = var.lb_subnet_id
  
}

resource "aws_lb_target_group_attachment" "demo-target-group-lb-attachment" {
    target_group_arn = var.target_group_arn
    target_id = var.python_app_instance_id
    port = "5000"
  
}

resource "aws_lb_listener" "python-app-lb-http-listener" {
    load_balancer_arn = aws_lb.python-app-lb.arn
    port = "80"
    protocol = "HTTP"

    default_action {
      type = "forward"
      target_group_arn = var.target_group_arn
    }
  
}

resource "aws_lb_listener" "python-app-lb-https-listener" {
    load_balancer_arn = aws_lb.python-app-lb.arn
    port = "443"
    protocol = "HTTPS"
    ssl_policy = var.ssl_policy_for_lb
    certificate_arn = var.certificate_arn

    default_action {
      type = "forward"
      target_group_arn = var.target_group_arn
    }
  
} 

output "py_lb_zone_id" {
    value = aws_lb.python-app-lb.zone_id
    description = "This will give the zone id of load balancer which we can use to create record in route53"
  
}

output "py_lb_dns_name" {
    value = aws_lb.python-app-lb.dns_name
    description = "This will give the dns name of load balancer which we can use to access our python app through load balancer"
  
}





# Creating infrastructure in same region as module-2 and not via Jenkins
/*
variable "target_group_arn" {}
variable "lb_name" {}
variable "lb_subnet_id" {}
variable "ssl_policy_for_lb" {} 
variable "certificate_arn" {}
variable "python_app_instance_id" {}
variable "alb_loadbalancer_arn" {}


resource "aws_lb_target_group_attachment" "demo-target-group-lb-attachment" {
    target_group_arn = var.target_group_arn
    target_id = var.python_app_instance_id
    port = "5000"
  
}

resource "aws_lb_listener" "demo-lb-http-listener" {
    load_balancer_arn = var.alb_loadbalancer_arn
    port = "5000"
    protocol = "HTTP"

    default_action {
      type = "forward"
      target_group_arn = var.target_group_arn
    }
  
}

resource "aws_lb_listener" "demo-lb-https-listener" {
    load_balancer_arn = var.alb_loadbalancer_arn
    port = "443"
    protocol = "HTTPS"
    ssl_policy = var.ssl_policy_for_lb
    certificate_arn = var.certificate_arn

    default_action {
      type = "forward"
      target_group_arn = var.target_group_arn
    }
  
}            */