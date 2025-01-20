provider "aws" {}

terraform {
  backend "s3" {
    #  тут хранятся и output !!! это важно
    bucket = "danik-aws-terraform-tfstate-files" # имя bucket
    key    = "dev/network/terraform.tfstate"     # это то, где будет храниться tfstate файл
    region = "us-east-1"                         # регион где расположен bucket
  }
}

# ===================================== Variables

variable "vpc_cidr" { # Переменнная 
  default = "10.0.0.0/16"
}

variable "env" { # Переменнная 
  default = "dev"
}

variable "public_subnet_cidrs" {
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24",
  ]

}

# ===================================== data

data "aws_availability_zones" "available" {}

# ===================================== Resources

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    "Name"       = "My VPC"
    "Enviroment" = "${var.env}"
  }
}

resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.public_subnet_cidrs, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    "Name" = "${var.env}-public-${count.index + 1}"
  }
}

resource "aws_route_table" "public_subnets" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = {
    "Name" = "${var.env}-route-public-subnets"
  }
}

resource "aws_route_table_association" "public_routes" {                 # это подключение ранее созданной route_table к ранее созданной subnet
  count          = length(aws_subnet.public_subnets[*].id)               # тут мы ассоциирием route table со вмести подсетями которые создали ранее 
  route_table_id = aws_route_table.public_subnets.id                     # какую таблицу
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index) # к какой подсети

}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    "Name"       = "My IG"
    "Enviroment" = "${var.env}"
  }
}
