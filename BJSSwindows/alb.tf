resource "aws_alb" "bjsstest_alb" {
  name               = "WebAppLoadBalancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.bjssalbsg.id}"]
  subnets            = "${aws_subnet.PublicSubnet.*.id}"
  depends_on         = ["aws_security_group.bjssalbsg"]
  tags = {
    Environment = "production"
  }

}
#Applicatio LoadBalancer target group
resource "aws_alb_target_group" "targetgroup" {
  name     = "albTargetGroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.bjsstest_vpc.id}"
  health_check {
      path = "/"
      port = "80"
      protocol = "HTTP"
      healthy_threshold = 5
      unhealthy_threshold = 2
      interval = 5
      timeout = 4 
      matcher = "200"

  }
  depends_on = ["aws_vpc.bjsstest_vpc"]
}

#Attaching an instance to the target group
resource "aws_alb_target_group_attachment" "bjss_target_group_attachment" {
  target_group_arn = "${aws_alb_target_group.targetgroup.arn}"  
  count  = "${length(var.public_subnet_cidr)}"
  port             = 80
  target_id        = "${element(aws_instance.bjsstestwindows.*.id, count.index)}"
}

# Adding a listener
resource "aws_alb_listener" "bjssfrontend" {
  load_balancer_arn = "${aws_alb.bjsstest_alb.arn}"
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.targetgroup.arn}"
  }
  #This would depend on the load balancer and target group
  depends_on = ["aws_alb.bjsstest_alb", 
                        "aws_alb_target_group.targetgroup"
                        ]
  
}
