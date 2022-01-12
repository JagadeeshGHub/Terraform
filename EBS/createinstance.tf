resource "aws_instance" "myfirstinstance" {
    ami               = "ami-06a0b4e3b7eb7a30"
    instance_type     = "t2.micro"
    availability_zone = "us-east-2a"

    tags = {
    Name = "custom_instance"
  }
}

resource "aws_ebs_volume" "ebsvolume" {
  availability_zone = "ap-south-1a"
  size              = 5
  type              = "gp2"

  tags = {
    Name = "EBS-Volume"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebsvolume.id
  instance_id = aws_instance.myfirstinstance.id
}