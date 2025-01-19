provider "aws" {
  region = "us-east-1"
  default_tags { # тэги которые будут применениы к каждому ресурсу
    tags = {
      "Owner"      = "Daniil"
      "Enviroment" = "Test"
    }
  }
}

#================================== aws_instance
resource "aws_instance" "Server" {
  #count         = 1                       # даже если тут один, то это все равно будет массив и обращаться надо будет через []
  ami           = "ami-043a5a82b6cf98947" # ami - amazom machine images
  instance_type = "t2.nano"
  tags = {
    "Name" = "Linux AWS"
  }
  vpc_security_group_ids = [aws_security_group.SG_port_22.id, aws_security_group.SG_ports_80_443.id]
  # важно в конце aws_security_group.SG_port_22 указывать.id, так как тут нуженн массив ids
  # когда мы привяваем SG через ресурс(aws_security_group), то автоматически создается зависимость для SG, 
  # те сначала создатся instance, потом к нему прикрепятся SG
}

#================================== aws_security_group
# 1 ingress\engree = 1 правило
# те таких ingress\engree в одном resource можно создавать сколько угодно

resource "aws_security_group" "SG_port_22" {
  name        = "SG_port_22"
  description = "1-Allow ssh connection "

  ingress { # приходит на инстансе
    from_port        = 22
    to_port          = 22
    protocol         = "TCP" # если указываем порт, то нужно указывать протокол
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {                  # уходит с инстансе
    from_port        = 0    # любой
    to_port          = 0    # любой 
    protocol         = "-1" # любой 
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    "Name" = "SG Linux AWS"
  }
}

resource "aws_security_group" "SG_ports_80_443" {
  name        = "SG_ports_80_443"
  description = "1-Allow ssh connection "

  ingress { # правило для входящего трафика по 80 порту
    from_port        = 80
    to_port          = 80
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress { # правило для входящего трафика по 443 порту
    from_port        = 443
    to_port          = 443
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {                  # уходит с инстансе
    from_port        = 0    # любой
    to_port          = 0    # любой 
    protocol         = "-1" # любой
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    "Name" = "SG Linux AWS"
  }
}
