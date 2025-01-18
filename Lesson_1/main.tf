provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      "Enviromet" = "Dev"
      "Owner"     = "Daniil"
    }
  }
}

resource "aws_instance" "name1" {
  count         = 3                       # Создаст 3 сервера
  ami           = "ami-04b4f1a9cf54c11d0" # надо брать только для того региона, в котором поднимается instance. Для каждого региона свои ami для тех же самых образов
  instance_type = "t3.micro"
  tags = {
    "Name" = "My Ubuntu"
    "Type" = "WebServer"
  }
}
