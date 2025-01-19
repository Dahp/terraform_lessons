resource "aws_instance" "my_webserver" {
  count                  = 1
  ami                    = "ami-043a5a82b6cf98947"
  instance_type          = "t2.nano"
  vpc_security_group_ids = [aws_security_group.SG_web.id]
  tags = {
    "Name" = "First server"
  }
}
