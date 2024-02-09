# create ec2
#ami
#instance type
#securty group
#ebs volume
#userdata
#zone
#pemfile
# vpcid - get with data block 

data "aws_vpc" "default" {
  default = "true"

}

# or directly you can hardcore also by using console and cpy paste vpcid 

resource "aws_security_group" "enginx" {
  name        = "enginx"
  description = "Allow inbound traffic and all outbound traffic for enginx"
  vpc_id      = "vpc-06a4e9a233196c1f4"
#   vpc_id      = data.aws_vpc.id 
  tags = {
    Name = "enginx"
  }
}

resource "aws_vpc_security_group_ingress_rule" "inbound_ssh" {
  security_group_id = aws_security_group.enginx.id
  cidr_ipv4         = "114.29.234.246/32"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "inbound_http" {
  security_group_id = aws_security_group.enginx.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "outbount_nginx_ivp4" {
  security_group_id = aws_security_group.enginx.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "outbount_nginx_ivp6" {
  security_group_id = aws_security_group.enginx.id'
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# data "aws_ami" "amazon" {
# filters{

# }

# }

#create ec2
resource "aws_instance" "nginx" {
  ami           = "ami-*"
#   ami           = data.aws_ami.amazon.id
#   instance_type = "t2.micro"
  instance_type = var.instance_type  
  count = 3 //for loop (index --0--1--2)
  #//for_each (to spreed across zone)
#   key_name = "apache-tf" //which is already exist
  key_name = var.publickey
  vpc_security_group_ids =  [aws_security_group.enginx.id] 
  #//list 
  user_data = file(nginx.sh)
  depends_on = [ aws_security_group.enginx ]
  tags = {
    Name = "nginx"
  }
}


