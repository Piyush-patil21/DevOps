variable "python_app_domain_name" {}
variable "py_hosted_zone_id" {}
  

# data "aws_acm_certificate" "python-app-acm-arn" {
#     domain = var.python_app_domain_name
#     statuses = ["AMAZON_ISSUED"]
#     most_recent = true

# }

resource "aws_acm_certificate" "python-app-acm-arn" {
  domain_name       = var.python_app_domain_name
  validation_method = "DNS"

  tags = {
    Environment = "dev"
  }

  lifecycle {
    create_before_destroy = false
  }
}

resource "aws_route53_record" "py-validation" {
  for_each = {
    for dvo in aws_acm_certificate.python-app-acm-arn.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id = var.py_hosted_zone_id # replace with your Hosted Zone ID
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 60
}


output "python_app_certificate_arn" {
    value = aws_acm_certificate.python-app-acm-arn.arn
    description = "This will give the arn of certificate which we can use to attach with load balancer"
}