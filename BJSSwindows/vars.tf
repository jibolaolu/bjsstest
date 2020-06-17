variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "eu-west-2"
}
variable "key_pair" {
  default = "LinuxKeyPair"
}


variable "ami_id" {
    type = "map"
    default =  {
      eu-west-2 = "ami-0d8aee0fe327c6fb2"
      eu-west-1 = "ami-08b8bf0a2fb1864a2"
 }
}
variable "subnet_id" {
   default = "subnet-7d4fef07"   
}

variable "region" {
  
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

variable "public_subnet_cidr" {
  type = "list"
}

variable "private_subnet_cidr" {
  type = "list"
}

variable "vpc_cidr" {
  
}








