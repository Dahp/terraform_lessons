provider "aws" {}

data "terraform_remote_state" "network" { # тут мы берем данные 
  #  тут хранятся и output !!! это важно
  backend = "s3"
  config = {
    bucket = "danik-aws-terraform-tfstate-files" # имя bucket
    key    = "dev/network/terraform.tfstate"     # это то, где будет храниться tfstate файл
    region = "us-east-1"                         # регион где расположен bucket
  }
}

terraform {
  backend "s3" {
    #  тут хранятся и output !!! это важно
    bucket = "danik-aws-terraform-tfstate-files" # имя bucket
    key    = "dev/SG/terraform.tfstate"          # это то, где будет храниться tfstate файл
    region = "us-east-1"                         # регион где расположен bucket
  }
}

resource "aws_security_group" "main" {
  name   = "My SG"
  vpc_id = data.terraform_remote_state.network.outputs.vpc_id
  dynamic "ingress" {
    for_each = ["80", "443"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [data.terraform_remote_state.network.outputs.vpc_cidr]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "SG-1"
  }
}

output "data_network" {
  value = data.terraform_remote_state.network
}
