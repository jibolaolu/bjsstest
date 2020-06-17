terraform {
  backend "s3" {
    bucket = "seunadio-tfstate"
    key    = "bjss/bjssapp/terraform.tfstate"
    region = "eu-west-2"
  }
}