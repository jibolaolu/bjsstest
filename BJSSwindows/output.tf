output "vpc_id" {
  value = "${aws_vpc.bjsstest_vpc.id}"
}
output "ec2_name" {
  value = "${aws_instance.bjsstestwindows.*.id}"
}
output "alb_name" {
  value = "${aws_alb.bjsstest_alb.dns_name}"
}