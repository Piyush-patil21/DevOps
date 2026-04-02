variable "ami_id" {}
# variable "public_key_name" {}
variable "python_app_public_subnet_id" {}
variable "security_group_id" {}
variable "python_app_basic_sg_id" {}
variable "python_app_user_data" {}
variable "public_key_name" {}


resource "aws_key_pair" "demo-key-pair" {
    key_name = "aws-key"
    public_key = var.public_key_name
  
}

resource "aws_instance" "python-app-instance" {
  ami           = var.ami_id
  instance_type = "t3.small"
  subnet_id     = var.python_app_public_subnet_id
  security_groups = [var.security_group_id, var.python_app_basic_sg_id]
  key_name = "awskey"
  associate_public_ip_address = true
  user_data = var.python_app_user_data
  tags = {
    Name = "dev-python-app-instance"
  }

}

# resource "aws_key_pair" "aws-key-pair" {
#   key_name = "aws-key"
#   public_key = var.public_key_name
  
# }

output "python_app_instance_id" {
  value = aws_instance.python-app-instance.id
  
}