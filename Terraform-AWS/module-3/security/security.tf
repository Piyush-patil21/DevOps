#This is new Security-group that will be craated using Jenkins script

variable "python_app_vpc_id" {}
variable "python_app_basic_sg_name" {}
variable "mysql_sg_name" {}
variable "python_app_sg_name" {}


resource "aws_security_group" "python-app-basic-sg" {
    name = var.python_app_basic_sg_name
    description = "Security group for Jenkins server"
    vpc_id = var.python_app_vpc_id 
    ingress {
        from_port = 22
        to_port = 22
        protocol = "ssh"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}


resource "aws_security_group" "python-app-security-group" {
    name = var.python_app_sg_name
    description = "Security group for Python application server"
    vpc_id = var.python_app_vpc_id 
    ingress {
        from_port = 5000
        to_port = 5000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"] 
    }
  
}

resource "aws_security_group" "my-sql-sg" {
    name = var.mysql_sg_name
    description = "Security group for MySQL server"
    vpc_id = var.python_app_vpc_id 
    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

}

output "python_app_basic_sg_id" {
    value = aws_security_group.python-app-basic-sg.id
    description = "This will let know about the security group id of python app server"
  
}

output "python_app_sg_id" {
    value = aws_security_group.python-app-security-group.id
    description = "This will let know about the security group id of python app server" 
}

output "mysql_sg_id" {
    value = aws_security_group.my-sql-sg.id
    description = "This will let know about the security group id of mysql server" 
  
}



# If you only want to create security group for python app and mysql server only then use below code
# This infracture will be created in same region as module-2 and not via Jenkins

/*
resource "aws_security_group" "my-sql-sg" {
    name = var.mysql-sg_name
    description = "Security group for MySQL server"
    vpc_id = var.vpc_id 
    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

}

resource "aws_security_group" "python-app-security-group" {
    name = var.python-app-sg_name
    description = "Security group for Python application server"
    vpc_id = var.vpc_id 
    ingress {
        from_port = 5000
        to_port = 5000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"] 
    }
  
}


output "python_app_sg_id" {
    value = aws_security_group.python-app-security-group.id
    description = "This will let know about the security group id of python app server"
  
}        */