provider "aws" {
  default_tags {
    tags = {
      "Owner"  = "Daniil"
      "Number" = "Lesson 5"
    }
  }
}

# Пример с life_cycle_example для демонстрации настроек при пересодании ресурса
resource "aws_instance" "life_cycle_example" {
  ami                    = "ami-043a5a82b6cf98947"
  instance_type          = "t2.nano"
  vpc_security_group_ids = [aws_security_group.sg_webserver] # подключаем созданную SG
  tags = {
    "Name" = "life_cycle_example"
  }
  lifecycle {
    prevent_destroy = true # это запрещает удалять данный ресурс, те если будут сделаны какие то изменения,
    # которые приводят к удалению уже созданного ресурса, он выполнены НЕ будут. Поумолчанию стоит false

    ignore_changes = ["ami", "instance_type"]
    #не создавать ресурс заново, если изменяется перечисленный параметр
  }
}

resource "aws_instance" "ZeroDownTime_example" {
  ami                    = "ami-043a5a82b6cf98947"
  instance_type          = "t2.nano"
  vpc_security_group_ids = [aws_security_group.sg_webserver] # подключаем созданную SG
  tags = {
    "Name" = "ZeroDownTime_example"
  }
  lifecycle {
    create_before_destroy = true
    # те сначала ресурс создай, а только потом убей существующий, который будет заменен новым
  }
}

resource "aws_security_group" "sg_webserver" {
  name = "my sg for web"

  dynamic "ingress" {
    for_each = ["80", "443", "8080", "8081", "8082", "8083"]
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
    "Name" = "sg_webserver_1"
  }
}
