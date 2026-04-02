variable "instance_type" {}
variable "ami_id" {}
variable "subnet_id" {}
variable "public_key_name" {}
variable "sg_jenkins" {}
variable "user_data" {}
variable "enable_public_ip" {}


resource "aws_instance" "demo-jenkins-instance" {
    ami = var.ami_id
    instance_type = var.instance_type
    key_name = "awskey"
    subnet_id = var.subnet_id
    vpc_security_group_ids = var.sg_jenkins
    user_data = var.user_data
    associate_public_ip_address = var.enable_public_ip
    tags = {
        Name = "dev-demo-jenkins-instance"
    }
  
}


resource "aws_key_pair" "demo-key-pair" {
    key_name = "aws-key"
    public_key = var.public_key_name
  
}

output "jenkins_server_id" {
  value = aws_instance.demo-jenkins-instance.id
}