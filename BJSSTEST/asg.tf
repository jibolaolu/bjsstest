resource "aws_autoscaling_group" "bjssasg" {
  name = "${aws_launch_configuration.bjsslaunchconfig.name}"
  min_size             = 1
  desired_capacity     = 2
  max_size             = 3
  vpc_zone_identifier             = "${aws_subnet.public_subnets.*.id}"
  launch_configuration = "${aws_launch_configuration.bjsslaunchconfig.name}"
  health_check_type    = "EC2"
  
  target_group_arns = ["${aws_alb_target_group.albtg.arn}"]
  default_cooldown = 30
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "${var.service_name}-apache"
    propagate_at_launch = true
  }
  # Required to redeploy without an outage.
  lifecycle {
    create_before_destroy = true
  }
}
