provider "aws" {
access_key = "AKIAYA7EJII5M62WAOEF"
secret_key = "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"
region = "ap-south-1"
}

resource "aws_instance" "myfirstinstance" {
ami = "ami-06a0b4e3b7eb7a300"
instance_type = "t2.micro"
tags = {
name = "RedHat02"
}
}
