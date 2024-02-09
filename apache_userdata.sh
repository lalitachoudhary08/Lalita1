#!/bin/bash
#apache installation 
#userdata will be executed by root user bydefault 
# ec2 --root/ec2-user
yum update -y
yum install httpd -y
systemctl start httpd
systemctl unable httpd 
