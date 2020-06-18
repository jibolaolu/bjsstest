resource "aws_vpc" "bjsstest_vpc" {
    cidr_block           = "${var.vpc_cidr}"
    instance_tenancy     = "default"
    enable_dns_hostnames = true

    tags = {
        Name = "Bjss Main VPC"
    }
  
}
# 2. Security has been moved out

#3. Adding the Internet Gateway
resource "aws_internet_gateway" "bjsstest_IGW" {
  vpc_id = "${aws_vpc.bjsstest_vpc.id}"

  tags = {
    Name = "BJSS Internet Gateway"
  }
  depends_on = ["aws_vpc.bjsstest_vpc"]
}

#
resource "aws_eip" "EIP" {
    vpc = true
    tags = {
        Name = "Elastic IP"
    }
  
}

#Create Nat Gateway
resource "aws_nat_gateway" "bjssNATGW" {
    allocation_id   = "${aws_eip.EIP.id}"
    subnet_id       = "${aws_subnet.PublicSubnet[0].id}"

    tags = {
        Name = "Bjss NatGateWay"
    }
    depends_on = ["aws_eip.EIP", "aws_subnet.PublicSubnet"]
  
}


