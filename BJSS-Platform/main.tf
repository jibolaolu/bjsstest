data "template_file" "server-data" {
    template = "${file("template/server-data.tpl")}" 
}

resource "aws_instance" "bjsstest" {
    count = "${length(var.availability_zone)}"
    ami  = "${lookup(var.ami_id, var.AWS_REGION)}"
    instance_type = "t2.micro"
    availability_zone = "${element(var.availability_zone,count.index )}"
    key_name      = "${var.key_pair}"
    user_data     = "${data.template_file.server-data.rendered}"

    tags = {
        Name = "${element(var.availability_zone,count.index)}"

    }
    subnet_id = "${var.subnet_id}"
    vpc_security_group_ids = ["${aws_security_group.bjsssg.id}"]
  
}

