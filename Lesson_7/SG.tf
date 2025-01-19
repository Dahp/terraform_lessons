resource "aws_security_group" "SG-1" {
  name = "SG"
  tags = {
    "Name" = "SG-1"
  }

  dynamic "ingress" {
    for_each = ["80", "443", "8080", "8081"]
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
}
