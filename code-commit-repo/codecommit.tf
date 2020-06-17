resource "aws_codecommit_repository" "BJSS" {
  repository_name = "${var.repo_name}"
  default_branch = "${var.branch}"
  description = "This is used to create the codecommit repo"
  tags = {
    Name = "${var.tag_name}"
  }
}