variable "vpc_id" {}
variable "alb_target_group_name" {}
variable "alb_port" {}
variable "alb_path" {}
variable "jenkins_server_id" {}


resource "aws_lb_target_group" "demo-app-target-group" {
    name = var.alb_target_group_name
    port = var.alb_port
    protocol = "HTTP"
    vpc_id = var.vpc_id
    health_check {
        healthy_threshold = 4
        unhealthy_threshold = 2
        timeout = 5
        interval = 10
        path = var.alb_path
        port = "8080"

    }
}

resource "aws_lb_target_group_attachment" "demo-target-group-attach" {
    target_group_arn = aws_lb_target_group.demo-app-target-group.arn
    target_id = var.jenkins_server_id
    port = var.alb_port
  
}


output "target_group_arn" {
    value = aws_lb_target_group.demo-app-target-group.arn
    description = "We require this arn while attaching target group with load balancer"

}