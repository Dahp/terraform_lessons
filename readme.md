Импорт переменных среды `export $(cat .env | xargs)`
---
1) **Lesson_1**: aws_instance, default_tags
2) **Lesson_2**: 
    - Создаем инстансе aws_instance
    - Создаем SG aws_security_group, с несколькими rule ingress/engress
    - Подключаем (attche) созданные SG к aws_security_group при помощи vpc_security_group_id = []