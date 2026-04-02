variable "python_app_domain_name" {}
variable "py_lb_dns_name" {}
variable "py_lb_zone_id" {}

data "aws_route53_zone" "py-route53-domain" {
    name = "goprotech.click"
    private_zone = false
  
}

resource "aws_route53_record" "python-app-domain-record" {
    zone_id = data.aws_route53_zone.py-route53-domain.zone_id
    name = var.python_app_domain_name
    type = "A"

    alias {
        name = var.py_lb_dns_name
        zone_id = var.py_lb_zone_id
        evaluate_target_health = true
    }
  
}


output "py_hosted_zone_id" {
    value = data.aws_route53_zone.py-route53-domain.zone_id
    description = "This will give the hosted zone id of route53 which we can use later"
  
}