
resource "aws_security_group" "ec2_public_security_group" {
    name        = "${var.service_name}-scg"
    description = "Internet reaching access for public ec2s"
    vpc_id      = "${aws_vpc.bjssvpc.id}"

    ingress {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      security_groups = ["${aws_security_group.alb_security_group.id}"]
    }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    egress {
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      cidr_blocks     = ["0.0.0.0/0"]
    }

    tags = {
        Name = "${var.service_name}_public_security_group"
    }

    depends_on = ["aws_vpc.bjssvpc","aws_security_group.alb_security_group"]
}

resource "aws_security_group" "ec2_private_security_group" {
    name        = "EC2-private-scg"
    description = "Only allow public SG resources to access private instances"
    vpc_id      = "${aws_vpc.bjssvpc.id}"

    ingress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      security_groups = ["${aws_security_group.ec2_public_security_group.id}"]
    }
    
    egress {
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      cidr_blocks     = ["0.0.0.0/0"]
    }

    tags = {
        Name = "${var.service_name}_private_security_group"
    }

    depends_on = ["aws_vpc.bjssvpc","aws_security_group.ec2_public_security_group"]
}


resource "aws_security_group" "alb_security_group" {
  name = "ELB-SG"
  description = "ELB Security Group"
  vpc_id = "${aws_vpc.bjssvpc.id}"

  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow web traffic to load balancer"
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name ="${var.service_name}alb_security_group"
  }
}