resource "aws_route_table" "bjssPublicRouteTable" {
    vpc_id    = "${aws_vpc.bjsstest_vpc.id}"
    route {
        cidr_block  = "0.0.0.0/0"
        gateway_id  = "${aws_internet_gateway.bjsstest_IGW.id}"
    }

    tags = {
        Name = "PublicRouteTable"
    }
  depends_on = ["aws_vpc.bjsstest_vpc", "aws_internet_gateway.bjsstest_IGW"]
}

resource "aws_route_table_association" "publicroutetableassociation" {
    count = "${length(var.public_subnet_cidr)}"
    subnet_id = "${element(aws_subnet.PublicSubnet.*.id, count.index)}"
    route_table_id = "${aws_route_table.bjssPublicRouteTable.id}"
    depends_on  = ["aws_subnet.PublicSubnet", "aws_route_table.bjssPublicRouteTable"]
}

resource "aws_route_table" "bjssPrivateRouteTable" {
    vpc_id    = "${aws_vpc.bjsstest_vpc.id}"
    route {
        cidr_block  = "0.0.0.0/0"
        gateway_id  = "${aws_internet_gateway.bjsstest_IGW.id}"
    }

    tags = {
        Name = "Private RouteTable"
    }
  depends_on = ["aws_vpc.bjsstest_vpc", "aws_internet_gateway.bjsstest_IGW"]
}

resource "aws_route_table_association" "privateroutetableassociation" {
    count = "${length(var.private_subnet_cidr)}"
    subnet_id = "${element(aws_subnet.PrivateSubnet.*.id, count.index)}"
    route_table_id = "${aws_route_table.bjssPrivateRouteTable.id}"
    depends_on  = ["aws_subnet.PrivateSubnet", "aws_route_table.bjssPrivateRouteTable"]  
}
  



