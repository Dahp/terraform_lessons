provider "aws" {
  default_tags {
    tags = {
      "Owner"  = "Daniil"
      "Number" = "Lesson_4"
    }
  }
}

# На примере SG разберем как можно сделать одну функцию для ingress и туда через массив и цикл 
# передавать нужные порты, protocol, cidr_blocks и тд
resource "aws_security_group" "dynamic_sg" {
  name = "my dynamic sg"

  dynamic "ingress" {
    for_each = ["80", "443", "22", "1541", "8080", "55555"]
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
    "Name" = "Dynamic SG"
  }
}



