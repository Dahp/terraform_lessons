provider "aws" {
  default_tags {
    tags = {
      "Owner"  = "Daniil"
      "Number" = "Lesson_10"
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

# ================ Elastic IP
resource "aws_eip" "my_static_ip" {
  instance = aws_instance.my_instance_1.id
  tags = {
    "Name" = "Server IP"
  }
}

# ================ EC2
resource "aws_instance" "my_instance_1" {
  ami                    = data.aws_ami.latest_aws_linux.id
  instance_type          = "t2.nano"
  vpc_security_group_ids = [aws_security_group.SG-web.id]
  subnet_id              = aws_subnet.my_public_subnet.id
  tags = {
    "Name" = "Server_1"
  }
  depends_on = [data.aws_ami.latest_aws_linux, aws_subnet.my_public_subnet, aws_security_group.SG-web]
}

# ================ SG
resource "aws_security_group" "SG-web" {
  name   = "SG_web"
  vpc_id = aws_vpc.my_vpc.id
  dynamic "ingress" {
    for_each = ["80", "443", "9000"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "SG_1"
  }
}

# ================ VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.100.0.0/16"
  tags = {
    "Name" = "My_VPC"
  }
}

data "aws_vpc" "my_vpc" {
  filter {
    name   = "tag:Name"
    values = ["My_VPC"]
  }
  filter {
    name   = "state"
    values = ["available"]
  }
  depends_on = [aws_vpc.my_vpc]
}

# ======= Subnets
resource "aws_subnet" "my_public_subnet" {
  vpc_id                  = data.aws_vpc.my_vpc.id
  cidr_block              = "10.100.10.0/24"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "Public_subnet_1"
  }
  depends_on = [aws_vpc.my_vpc]
}

# ===================== IG
resource "aws_internet_gateway" "IG" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    "Name" = "My IG"
  }
}

