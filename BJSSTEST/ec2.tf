resource "aws_instance" "BJSSEC2" {
  count = "${length(var.public_subnet_cidr)}"
  ami =   "${var.ami}"
  instance_type = "${var.instance_type}"
  vpc_security_group_ids = ["${aws_security_group.ec2_public_security_group.id}"]
  subnet_id = "${aws_subnet.public_subnets[count.index].id}"
  key_name = "${var.key_pair}"
  iam_instance_profile = "${aws_iam_instance_profile.bjss_ec2_profile.name}"
  tags = {
    Name = "${format("BJSSEC2-%d", count.index+1)}"
  }
  user_data = file ("${path.module}/scripts/bootstrap.sh")
  depends_on = ["aws_vpc.bjssvpc","aws_subnet.public_subnets","aws_security_group.ec2_public_security_group"]
}

