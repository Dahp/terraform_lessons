provider "aws" {
  default_tags {
    tags = {
      "Owner"  = "Daniil"
      "Number" = "Lesson_()"
    }
  }
}

data "aws_ami" "latest_aws_linux" {
  most_recent = true
  owners      = ["137112412989"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
  }
}
