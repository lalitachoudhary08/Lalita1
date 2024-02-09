steps for vpc
1. create vpc (10.3.0.0/16)
2. create subnets (9 subnets-each zone wise)
-=------------------------------------------
app-subnet--10k--30k--cidr range /18 -48-
app-subnet1 - 10.3.0.0/18---10.3.63.254
app-subnet2 -10.3.64.0/18---10.3.127.254
app-subnet3 -10.3.128.0/18-10.3.191.254


data-subnet -8k-24k--cidr range - /21- 6
-=------------------------------------------
data-subnet1 - 10.3.192.0/21---10.3.199.254
data-subnet2 -10.3.200.0/21---10.3.207.254
data-subnet3 -10.3.208.0/21-10.3.215.254


public-subnet-256-1k--cidr range- /24 - 1k
-=------------------------------------------
public-subnet1 - 10.3.216.0/24---10.3.216.254
public-subnet2 -10.3.217.0/24---10.3.217.254
public-subnet3 -10.3.218.0/24-10.3.218.254

