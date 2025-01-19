# Например мы хотим чтобы DataBase создалась первой, а Application второй, и my_instance последней
# depends_on работает и при удалении(в обратном порядке, сначала у кого есть зависимости) и при создании.
# my_instance зависит то : DataBase и Application
# Application зависит от : DataBase
# А DataBase не от чего не зависит и должна создаться первой 

resource "aws_instance" "my_instance" {
  count         = 1
  ami           = "ami-043a5a82b6cf98947"
  instance_type = "t2.nano"
  tags = {
    "Name" = "my_instance"
  }
  vpc_security_group_ids = [aws_security_group.SG-1.id] # это тоже является dependency, так как сначала создатся instance
  # и только потом ему назначат SG
  depends_on = [aws_instance.Application, aws_instance.DataBase] # сюда можно указать зависимость от любого ресурса, не только instance
}

resource "aws_instance" "Application" {
  count         = 1
  ami           = "ami-043a5a82b6cf98947"
  instance_type = "t2.nano"
  tags = {
    "Name" = "Application"
  }
  depends_on = [aws_instance.DataBase]
}

resource "aws_instance" "DataBase" {
  count         = 1
  ami           = "ami-043a5a82b6cf98947"
  instance_type = "t2.nano"
  tags = {
    "Name" = "DataBase"
  }
}
