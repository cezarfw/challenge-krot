
# Informacoes globais

variable "name" {
  default = "kroton"
}

variable "region" {
  default = "us-east-1"
}

variable "tags" {
  type = map(string)
  default = {
    Name = "Kroton"
  }
}

# EC2

variable "ami" {
  default = "ami-09e67e426f25ce0d7"
}

variable "instance_type" {
  default = "t2.micro"
}

# S3

variable "acl" {
  default = "private"
}

variable "versioning" {
  default = false
}

variable "aws_key_pair" {
  default = "aws_cezar_virginia"

}

# VPC

variable "vpc_cidr" {
  default = "192.168.0.0/16"
}

variable "public_a_cidr" {
  default = "192.168.1.0/24"
}

variable "public_b_cidr" {
  default = "192.168.2.0/24"
}

variable "private_a_cidr" {
  default = "192.168.3.0/24"
}

variable "private_b_cidr" {
  default = "192.168.4.0/24"
}
