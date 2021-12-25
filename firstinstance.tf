provider "aws" {
access_key = "hi"
secret_key = "no"
region = "ap-south-1"
}

resource "aws_instance" "myfirstinstance" {
ami = "ami-06a0b4e3b7eb7a300"
instance_type = "t2.micro"
tags = {
name = "RedHat02"
}
}
