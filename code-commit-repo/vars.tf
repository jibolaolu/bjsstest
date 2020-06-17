variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "eu-west-2"
}
variable "codecommit" {
  default = "BJSS"
}
variable "repo_name" {
  default = "BJSS-REPO"
}
variable "branch" {
  default = "master"
}
variable "tag_name" {
  default = "BJSSTEAM"
}