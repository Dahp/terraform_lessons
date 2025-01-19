provider "aws" {
  default_tags {
    tags = {
      "Owner"  = "Daniil"
      "Number" = "Lesson_8"
    }
  }
}
#================================================================= data
data "aws_availability_zones" "my_AZ" {} # список все доступных зон в текущем регионе
data "aws_caller_identity" "current" {}  # Идентификационный номер учетной записи AWS для пользователя, который вызывает эту data source
data "aws_region" "current" {}           # выводит информацию о текущем регионе
data "aws_vpcs" "current" {}             # выводит информацию о vpc в текущем регионе
data "aws_vpc" "selected" {              # тут критерии фильтра можно указывать только однозначно, те если по этому фильтру находится несколько vpc, то будет ошибка
  # !!!!!!!!!!!!!! фильтры можно комбинировать и использовать одновременно 
  filter { # например находит vpc по умолчанию
    name   = "is-default"
    values = ["true"]
  }

  #   filter {                           # поиск по состоянию
  #     name   = "state"
  #     values = ["available"]
  #   }

  #   filter {              # поиск по имени
  #     name   = "tag:Name" # Фильтрация по тегу Name
  #     values = ["vpc-1"]  # Значение тега
  #   }
}

#================================================================= output
# output "data_aws_availability_zone" {
#   value = data.aws_availability_zones.my_AZ.names
# }

# output "data_aws_caller_identity" {
#   value = data.aws_caller_identity.current.account_id
# }


# output "data_aws_region_name" {
#   value = data.aws_region.current.name
# }
# output "data_aws_region_description" {
#   value = data.aws_region.current.description
# }


# output "data_aws_vpcs_id" {
#   value = data.aws_vpcs.current.id # в целом не очень понял пока зачем он, ведь возвращает: data_aws_vpcs_id = "us-east-1"
# }
# output "data_aws_vpcs_ids" {
#   value = data.aws_vpcs.current.ids # список id все vpc в текущем регионе
# }


# output "data_aws_vpc_id" {
#   value = data.aws_vpc.selected.id
# }
# output "data_aws_vpc_cidr" {
#   value = data.aws_vpc.selected.cidr_block
# }
