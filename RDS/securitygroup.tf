resource "aws_security_group" "securitygroup1" {
  name        = "securitygroup1"
  description = "Allow ssh connection"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    description      = "inbound"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "securityGroupSSH"
  }
}

resource "aws_security_group" "allow-mariadb" {
  vpc_id      = aws_vpc.myvpc.id
  name        = "allow-mariadb"
  description = "security group for Maria DB"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.securitygroup1.id]
  }
  
  tags = {
    Name = "allow-mariadb"
  }
}