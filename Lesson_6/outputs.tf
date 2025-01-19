# Делать output невероятно важно, так как это как создание глобальных переменных, 
#которыми можно будет пользоваться для состыковки с другими ресурсами
output "instance_id" {                    # вывод только id первого instance
  value = aws_instance.my_webserver[0].id # тут [0], потому что в aws_instance указано количество
  # хоть и указано count = 1. Он все равно будет создан как массив, поэтому обращение по индексу
}

output "instance_info" { # вывод всей информации об instance с именем my_webserver и номером [0] = 1
  value = aws_instance.my_webserver[0]
}

output "sg_info" { # вывод всей информации о SG с именем SG_web
  value = aws_security_group.SG_web
}
