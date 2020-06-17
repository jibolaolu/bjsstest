resource "aws_vpc" "bjssvpc" {
  cidr_block            = "${var.vpc_cidr}"
  instance_tenancy      = "default"
  enable_dns_hostnames  = true

  tags = {
      Name = "VPC_BJSS"
  }
}
resource "aws_internet_gateway" "IGW_BJSS" {
  vpc_id = "${aws_vpc.bjssvpc.id}"

  tags = {
    Name = "${var.service_name}-IGW"
  }
  depends_on = ["aws_vpc.bjssvpc"]
}

resource "aws_eip" "EIP" {
  vpc              = true
  tags = {
    Name = "EIP"
  }

}

resource "aws_nat_gateway" "NATGW" {
    allocation_id = "${aws_eip.EIP.id}"
    subnet_id = "${aws_subnet.public_subnets[0].id}"

    tags = {
        Name  = "NATGW"
    }
    depends_on = ["aws_eip.EIP","aws_subnet.public_subnets"]
  
}

