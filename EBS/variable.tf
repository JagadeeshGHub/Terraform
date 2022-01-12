variable "Access_Key" {
    default = "AKIAYA7EJII5NK6AEGMR"
}

variable "Secret_Key" {}

variable "AWS_Region" {
    default = "ap-south-1"
}

variable "AMI_Region" {
    type = map
    default = {
        ap-south-1 = "ami-0af25d0df86db00c1"
    }
}