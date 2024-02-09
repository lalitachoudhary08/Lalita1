#!/bin/bash
#in sell script you can write a function like below but it won't execute .. you have to call this function()
#function --2nd control goes here -2 
install_nginx () 
{

yum update -y
yum install nginx -y
systemctl start nginx
systemctl enable nginx

}
#// called the function as below 
#calling function-1st control comes here -1 
install_nginx 
