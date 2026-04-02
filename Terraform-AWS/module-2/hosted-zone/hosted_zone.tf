variable "domain_name" {}
variable "lb_zone_id" {}
variable "lb_dns_name" {}


data "aws_route53_zone" "route53-domain" {
    name = "goprotech.click"
  
}

resource "aws_route53_record" "route53-record" {
    zone_id = data.aws_route53_zone.route53-domain.zone_id
    name = var.domain_name
    type = "A"

    alias {
      name = var.lb_dns_name
      zone_id = var.lb_zone_id
      evaluate_target_health = true
    }

}

output "hosted_zone_id" {
    value = data.aws_route53_zone.route53-domain.zone_id
    description = "This will give the hosted zone id of our domain which we can use in certificate manager module to create certificate for our domain"
  
}