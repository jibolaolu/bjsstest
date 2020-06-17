resource "aws_iam_role_policy" "BJSSEC2_policy" {
  name = "bjss_policy"
  role = aws_iam_role.bjssec2_role.id

  policy = "${file("ec2-policy.json")}"
}

resource "aws_iam_role" "bjssec2_role" {
  name = "bjss_ec2_role"

  assume_role_policy = "${file("ec2-assume-policy.json")}"
}

resource "aws_iam_instance_profile" "bjss_ec2_profile" {
  name = "bjss_ec2_profile"
  role = "${aws_iam_role.bjssec2_role.name}"
}
