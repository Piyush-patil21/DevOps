#Jenkins Server Setup Infrastructure configuration variables
vpc_cidr         = "172.168.0.0/20"
vpc_name         = "dev-demo-vpc"
vpc_public_cidr  = ["172.168.0.0/24", "172.168.4.0/24"]
vpc_private_cidr = ["172.168.8.0/24", "172.168.12.0/24"]
av_zone1         = ["ap-south-1a", "ap-south-1b"]
sg_name          = "dev-demo-sg"

# instance_type = "t3.small"
ami_id = "ami-05d2d839d4f73aafb"
# subnet_id = tolist(module.networking.public_subnet_id)[0]   
public_key_name = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDkG/LgAAZk72ZoyEmBH2iCmW2RYWIiZC3qYs9rf1uaJ0HoMKhLD9wfuw7ArZmYJkxCDV9wuGV2Q1+h8oFY+F6jgrPPrz4/SxomR9V3hHyfnoz2BRIkoOspTSYJ30zxGkO9IDsGVUdDwI3hoIOywbrB0jckwMgTMDpYVRrTkU1l3YqzkPjHR7daR2qYRgi7uPiYUT6grsiQkzdkmJ76gVubK9T3bJ1fGpVuoe8y2r+uK1fyvmD5bAHUFbyHkL8vjfdWnly0fuME0PE9JgntVWJF7/HZeq/w/OcQQXyIMWumEXJoBTZvIpcP56shpXRQU0z8j19ROY1WuR1cHrucWV8GTxK2C4OpHv5n4Y/XiKCh0QLOspqit7UJQ18/fvj6HWTFy4yFKD9BwlzNHamkxxuSs8CoTucZXnIyf56GoIa5DzkLD1DpAE3PHjmOvUtcxjee2OQpByyoDpQgVMX/BZzhOO1kMuNasryHL7qD8xbxGtGSsr9e/qiNyUxH08hjlUE5kTqb8LDjjAv6vvYbr1GTLnL4jmImTXUtwjIxkwED1B42gml1VoB4BGSVPK5gVgHRFGihlLEDyFMGsv9JdZMZI6FaBW0XnyR4xqLb4bC0zWTLDQyGKJdZGGZOVsndbL6sjTXr8DarH7v15+2SAQSNcdvtWIJ2eZlJw6g7jme7IQ== ubuntu"


# Python App Setup Infrastructure configuration variables

python_app_sg_name       = "dev-python-app-sg"
python_app_basic_sg_name = "dev-python-app-basic-sg"
mysql_sg_name            = "dev-mysql-sg"
python_app_vpc_name      = "dev-python-app-vpc"
python_app_vpc_cidr      = "178.168.16.0/20"
python_app_public_cidr   = ["178.168.16.0/24", "178.168.20.0/24"]
python_app_private_cidr  = ["178.168.24.0/24", "178.168.28.0/24"]
python_app_av_zone1      = ["us-east-1a", "us-east-1b"]
python_app_domain_name   = "goprotech.click"