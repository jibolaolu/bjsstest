#data "template_file" "server-data" {
    #template = "${file("template/server-data.tpl")}" 
#}

resource "aws_instance" "bjsstestwindows" {
    count = "${length(var.public_subnet_cidr)}"
    ami  = "${lookup(var.ami_id, var.AWS_REGION)}"
    instance_type = "t2.micro"
    key_name      = "${var.key_pair}"
    #user_data     = "${data.template_file.server-data.rendered}"

    tags = {
        Name = "bjsstest-platform"

    }
    subnet_id = "${aws_subnet.PublicSubnet[count.index].id}"
    vpc_security_group_ids = ["${aws_security_group.bjsssg.id}"]
  
}



