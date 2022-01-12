resource "aws_instance" "myfirst" {
    ami           = lookup(var.AWS_AMI, var.AWS_Region)
    instance_type = "t2.micro"
    user_data     = file("installadocker.sh")

    tags = {
    Name = "custom_instance"
  }
}