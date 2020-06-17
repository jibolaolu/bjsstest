variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
  default = "eu-west-2"
}

variable "vpc_cidr" {
    
}

variable "instance_type" {
  default  = "t2.micro"
}

variable "ami" {
  default = "ami-00e8b55a2e841be44"
  
}

variable "public_subnet_cidr" {
  type = "list"

}

variable "private_subnet_cidr" {
  type = "list"
}

variable "availability_zone" {
  type = "list"
}

variable "public_subnet_names" {
  type = "list"
}

variable "private_subnet_names" {
  type = "list"
  
}

variable "key_pair" {
  default = "LinuxKeyPair"
}

variable "service_name" {
  description = "The name of the network"
  default     = "platform-test"
}

