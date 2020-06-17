resource "aws_launch_configuration" "bjsslaunchconfig" {
  name = "bjss-apache"
  image_id                    = "${var.ami}"
  instance_type               = "${var.instance_type}"
  security_groups             = ["${aws_security_group.alb_security_group.id}"]
  associate_public_ip_address = true
  key_name = "${var.key_pair}"
  user_data = file ("${path.module}/scripts/bootstrap.sh")
  lifecycle {
    create_before_destroy = true
  }
}