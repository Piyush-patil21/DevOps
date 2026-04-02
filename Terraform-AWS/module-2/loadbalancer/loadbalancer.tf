variable "lb_name" {}
variable "lb_security_group" {}
variable "lb_subnet_id" {}
variable "target_group_arn" {}
variable "ssl_policy_for_lb" {}
variable "certificate_arn" {}
variable "jenkins_server_id" {}


resource "aws_lb" "demo-app-lb" {
    name = var.lb_name
    internal = false
    load_balancer_type = "application"
    security_groups = [var.lb_security_group] 
    enable_deletion_protection = false
    subnets = var.lb_subnet_id
  
}

resource "aws_lb_target_group_attachment" "demo-target-group-lb-attachment" {
    target_group_arn = var.target_group_arn
    target_id = var.jenkins_server_id
    port = "8080"
  
}

resource "aws_lb_listener" "demo-lb-http-listener" {
    load_balancer_arn = aws_lb.demo-app-lb.arn
    port = "80"
    protocol = "HTTP"

    default_action {
      type = "forward"
      target_group_arn = var.target_group_arn
    }
  
}

resource "aws_lb_listener" "demo-lb-https-listener" {
    load_balancer_arn = aws_lb.demo-app-lb.arn
    port = "443"
    protocol = "HTTPS"
    ssl_policy = var.ssl_policy_for_lb
    certificate_arn = var.certificate_arn

    default_action {
      type = "forward"
      target_group_arn = var.target_group_arn
    }
  
}

output "lb_dns_name" {
    value = aws_lb.demo-app-lb.dns_name
    description = "This will give the dns name of load balancer which we can use to access our jenkins server through load balancer"
  
}

output "lb_zone_id" {
    value = aws_lb.demo-app-lb.zone_id
    description = "This will give the zone ID of the load balancer"
  
}

output "alb_loadbalancer_arn" {
    value = aws_lb.demo-app-lb.arn
    description = "This will give the arn of the load balancer which we can use in listener resource"
  
}