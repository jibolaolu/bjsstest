resource "aws_security_group" "bjsssg" {
    name        = "bjsssg"
    description = "This allows the ssh connection and access the app page"
    vpc_id      = "${aws_vpc.bjsstest_vpc.id}"

    ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        }

    tags = {
        Name = "BJSS_Security_Group"
    }
  
    depends_on = ["aws_vpc.bjsstest_vpc"]
}

resource "aws_security_group" "bjssalbsg" {
    name = "bjss alb sg"
    description = "Allows ALB SG"
    vpc_id = "${aws_vpc.bjsstest_vpc.id}"

    ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        }

    tags = {
        Name = "LoadBalancer_Security_Group"
    }
  
}

