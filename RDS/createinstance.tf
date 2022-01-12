resource "aws_instance" "myfirstinstance" {
    ami           = lookup(var.AWS_AMI, var.AWS_Region)
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.securitygroup1.id]

    tags = {
    Name = "custom_instance"
  }
}