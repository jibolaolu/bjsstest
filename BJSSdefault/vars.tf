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
      eu-west-2 = "ami-00e8b55a2e841be44"
      eu-west-1 = "ami-0ea3405d2d2522162"
 }
}
variable "subnet_id" {
   default = "subnet-7d4fef07"   
}

variable "subnet_id_1" {
  default = "subnet-ea8573a6"
}
variable "region" {
  
}

variable "availability_zone" {
  type = "list"
  default = []
  
}

variable "vpc_id" {
  default = "vpc-6d33a105"
}

variable "internetgateway" {
  default = "igw-0cc44e80e15ccb28f"
}
variable "public_subnet_cidr" {
  type = "list"
}








