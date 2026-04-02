/*
module "networking" {
  source           = "./module-2/networking"
  vpc_cidr         = var.vpc_cidr
  vpc_public_cidr  = var.vpc_public_cidr
  vpc_private_cidr = var.vpc_private_cidr
  vpc_name         = var.vpc_name
  av_zone1         = var.av_zone1

}

module "security" {
  source  = "./module-2/security"
  sg_name = var.sg_name
  vpc_id  = module.networking.demo_vpc_id
  # here we have first called vpc_id in the networking module as output value and then we are using that output value in the security module as input value for vpc_id.
}

module "jenkins-server" {
  source          = "./module-2/jenkins"
  instance_type   = "t3.small"
  ami_id          = var.ami_id
  public_key_name = var.public_key_name

  # here we are using tolist function to convert the list of public subnet id into single value because in the jenkins module we have defined subnet_id variable as single value and not list. So, to avoid that error we are using tolist function here.
  subnet_id        = tolist(module.networking.public_subnet_id)[0]
  sg_jenkins       = [module.security.jenkins_sg_id]
  enable_public_ip = true
  user_data        = templatefile("./module-2/jenkins-script/jenkins_setup.sh", {})

}

module "alb-target-group" {
  source                = "./module-2/alb-targetgroup"
  vpc_id                = module.networking.demo_vpc_id
  alb_target_group_name = "dev-demo-target-group"
  alb_port              = "8080"
  alb_path              = "/admin"
  jenkins_server_id     = module.jenkins-server.jenkins_server_id

}

module "loadbalancer" {
  source            = "./module-2/loadbalancer"
  lb_name           = "dev-demo-alb"
  lb_security_group = module.security.jenkins_sg_id
  lb_subnet_id      = tolist(module.networking.public_subnet_id)
  target_group_arn  = module.alb-target-group.target_group_arn
  ssl_policy_for_lb = "ELBSecurityPolicy-FS-1-2-Res-2019-08"
  certificate_arn   = module.certificate-manager.demo_acm_arn
  jenkins_server_id = module.jenkins-server.jenkins_server_id

}

module "hosted-zone" {
  source      = "./module-2/hosted-zone"
  domain_name = "jenkins.goprotech.click"
  lb_dns_name = module.loadbalancer.lb_dns_name
  lb_zone_id  = module.loadbalancer.lb_zone_id

}

module "certificate-manager" {
  source         = "./module-2/certificates"
  domain_name    = "jenkins.goprotech.click"
  hosted_zone_id = module.hosted-zone.hosted_zone_id

}       */


module "python-app-networking" {
  source                  = "./module-3/networking"
  python_app_vpc_name     = var.python_app_vpc_name
  python_app_vpc_cidr     = var.python_app_vpc_cidr
  python_app_public_cidr  = var.python_app_public_cidr
  python_app_private_cidr = var.python_app_private_cidr
  python_app_av_zone1     = var.python_app_av_zone1

}

module "python-app-sg" {
  source                   = "./module-3/security"
  python_app_vpc_id        = module.python-app-networking.python_app_vpc_id
  python_app_sg_name       = var.python_app_sg_name
  mysql_sg_name            = var.mysql_sg_name
  python_app_basic_sg_name = var.python_app_basic_sg_name

}

module "python-app-server" {
  source                      = "./module-3/application-ec2"
  ami_id                      = var.ami_id
  python_app_public_subnet_id = tolist(module.python-app-networking.python_app_public_subnet_id)[0]
  security_group_id           = module.python-app-sg.python_app_sg_id
  python_app_basic_sg_id      = module.python-app-sg.python_app_basic_sg_id
  python_app_user_data        = templatefile("./module-3/apache-install/install_apache.sh", {})

}

module "python-target-group" {
  source                       = "./module-3/app-targetgroup"
  python_app_port              = "5000"
  python_app_instance_id       = module.python-app-server.python_app_instance_id
  python_app_vpc_id            = module.python-app-networking.python_app_vpc_id
  python_app_target_group_name = "dev-python-app-target-group"

}

module "python-app-lb" {
  source                 = "./module-3/app-loadbalancer"
  python_app_lb_name     = "dev-python-app-alb"
  lb_security_group      = module.python-app-sg.python_app_basic_sg_id
  lb_subnet_id           = tolist(module.python-app-networking.python_app_public_subnet_id)
  target_group_arn       = module.python-target-group.python_app_target_group_arn
  python_app_instance_id = module.python-app-server.python_app_instance_id
  ssl_policy_for_lb      = "ELBSecurityPolicy-FS-1-2-Res-2019-08"
  certificate_arn        = module.python-certificate.python_app_certificate_arn

}

module "py-hosted-zone" {
  source                 = "./module-3/py-hostedzone"
  python_app_domain_name = var.python_app_domain_name
  py_lb_dns_name         = module.python-app-lb.py_lb_dns_name
  py_lb_zone_id          = module.python-app-lb.py_lb_zone_id

}

module "python-certificate" {
  source                 = "./module-3/py-certificate"
  python_app_domain_name = var.python_app_domain_name
  py_hosted_zone_id      = module.py-hosted-zone.py_hosted_zone_id

}

module "rds_db_instance" {
  source               = "./module-3/database"
  db_subnet_group_name = "dev_proj_1_rds_subnet_group"
  subnet_groups        = tolist(module.python-app-networking.python_app_public_subnet_id)
  rds_mysql_sg_id      = module.python-app-sg.mysql_sg_id
  mysql_db_identifier  = "mydb"
  mysql_username       = "dbuser"
  mysql_password       = "dbpassword"
  mysql_dbname         = "devprojdb"
}


# module "python-app-loadbalancer" {
#   source           = "./module-3/app-loadbalancer"
#   target_group_arn = module.alb-target-group.target_group_arn
#   lb_name          = "dev-demo-alb"
#   # lb_security_group = module.python-app-sg.python_app_sg_id
#   lb_subnet_id           = tolist(module.networking.public_subnet_id)
#   ssl_policy_for_lb      = "ELBSecurityPolicy-FS-1-2-Res-2019-08"
#   certificate_arn        = module.certificate-manager.demo_acm_arn
#   python_app_instance_id = module.python-app-server.python_app_instance_id
#   alb_loadbalancer_arn   = module.loadbalancer.alb_loadbalancer_arn

# }



# When specifying the value for output block you should always use "module.<module_name>.<output_name>" format.
# output "vpc_default_route" {
#   value       = module.networking.vpc_default_route
#   description = "This will let know about the route table id of default route"
# }

