# resource "aws_instance" "tomcat" {
#   ami = 
#   instance_type = 
# }


resource "aws_key_pair" "tomcat" {
  key_name   = "tomcat-tf"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILjRmGHNAvqLxptaVNn/9mrjxqCv4Y00YmITgMbyh+cv harsh@Lalita"
}

data "aws_ami" "amazon-tomcat" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023.3.20240131.0-kernel-6.1-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"] # Canonical

}

resource "aws_security_group" "tomcat" {
  name        = "tomcat"
  description = "Allow TLS inbound traffic and all outbound traffic"
  # ingress =[]
  # egress = []
  tags = {
    Name = "tomcat"
  }
}

resource "aws_vpc_security_group_ingress_rule" "tomcat-ssh" {
  security_group_id = aws_security_group.tomcat.id
  cidr_ipv4         = "114.29.234.246/32"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "tomcat-http" {
  security_group_id = aws_security_group.tomcat.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.tomcat.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.tomcat.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon-tomcat.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.tomcat.key_name
  vpc_security_group_ids = [aws_security_group.tomcat.id]
  user_data = file("tomcat_userdata.sh")

  tags = {
    Name = "HelloWorld"
    Team = "devops"
    Manual = "false"
    terraform = "true" 
  }
}


