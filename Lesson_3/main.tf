#=================== provider
provider "aws" {
  #region = "us-east-1" #теперь берется из .env
  default_tags {
    tags = {
      "Owner"  = "Daniil"
      "Number" = "Lesson_3"
    }
  }
}

#=================== instance

resource "aws_instance" "AWS-Linux" {
  count         = 1 # тут все равно будет массив и надо будет обращаться через [0]
  ami           = "ami-043a5a82b6cf98947"
  instance_type = "t2.nano"
  user_data = templatefile("file.sh.tpl", {
    f_name = "Daniil",
    l_name = "Miranovich",
    names  = ["Name1", "Name2", "Name3"]
  })
  tags = {
    "Name" = "Back-end"
  }
}
