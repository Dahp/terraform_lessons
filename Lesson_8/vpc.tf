# ============================================= Пример 1
# Найдем сеть vpc-dannik

# 1) создаем vpc
resource "aws_vpc" "vpc-1" {
  cidr_block = "10.1.0.0/16"
  tags = {
    "Name"   = "vpc-danik"
    "Shared" = "test"
  }
}

# 2) Ищем эту vpc по tag:Name
data "aws_vpc" "vpc_danik" {
  filter {
    name   = "tag:Name"
    values = ["vpc-danik"]
  }
  depends_on = [aws_vpc.vpc-1]
}

output "data_vpc_danik_id" {
  value = data.aws_vpc.vpc_danik.id
}

output "data_vpc_danik_cidr" {
  value = data.aws_vpc.vpc_danik.cidr_block
}

# 3) Создаем subnet для найденной vpc
resource "aws_subnet" "public_subnet_vpc_1" {
  vpc_id                  = data.aws_vpc.vpc_danik.id
  cidr_block              = "10.1.10.0/24"
  availability_zone       = data.aws_availability_zones.my_AZ.names[0]
  map_public_ip_on_launch = false
  tags = {
    "Name"   = "Public_subnet_danik"
    "AZ"     = "${data.aws_availability_zones.my_AZ.names[0]}"
    "Shared" = "test"
  }
}

resource "aws_subnet" "public_subnet_vpc_2" {
  vpc_id                  = data.aws_vpc.vpc_danik.id
  cidr_block              = "10.1.20.0/24"
  availability_zone       = data.aws_availability_zones.my_AZ.names[1]
  map_public_ip_on_launch = false
  tags = {
    "Name"   = "Public_subnet_robert"
    "AZ"     = "${data.aws_availability_zones.my_AZ.names[1]}"
    "Shared" = "test"
  }
}

data "aws_subnets" "name" {
  filter { # ищем все подсети которые пренадлежат нашей vpc
    name   = "vpc-id"
    values = [data.aws_vpc.vpc_danik.id]
  }
  filter { # ищем все подсети с tag = "Public_subnet_robert"
    name   = "tag:Shared"
    values = ["test"]
  }
}

output "data_aws_subnets_id" { # выведет list с ids подсетей, которые пренадлежат нужной vpc и имеют tag = "Public_subnet_robert"
  value = data.aws_subnets.name.ids
}

# =============================================
resource "aws_vpc" "vpc-2" {
  cidr_block = "10.2.0.0/16"
  tags = {
    "Name"   = "vpc-2"
    "Shared" = "test"
  }
}

resource "aws_vpc" "vpc-3" {
  cidr_block = "10.3.0.0/16"
  tags = {
    "Name" = "vpc-3"
  }
}
