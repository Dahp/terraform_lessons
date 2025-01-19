Импорт переменных среды `export $(cat .env | xargs)`.
Внутри файла `.env`
```ruby
AWS_DEFAULT_REGION=us-east-1
AWS_ACCESS_KEY_ID=""
AWS_SECRET_ACCESS_KEY=""
```
---
1) **Lesson_1**: `aws_instance`, `default_tags`
2) **Lesson_2**: 
    - Создаем инстансе `aws_instance`
    - Создаем SG `aws_security_group`, с несколькими rule ingress/engress
    - Подключаем (attache) созданные SG к `aws_security_group` при помощи `vpc_security_group_id = []`
    - Используем `user_data = file("file.sh")` для выполнения скрипта при инициализации
3) **Lesson_3**:
    - Использование в `user_data =  templatefile("file.sh.tpl", {})` - это улучшение для `user_data = file("file.sh")`, так как мы можем посылать
    теперь переменные в file.sh, которые будут использоваться в скрипте
4) **Lesson_4**:
    - Динамичные блоки кода. Те можно генерировать для код внутри терраформ. Реализация принципа `DRY`
5) **Lesson_5**:
    - `Lifecycle` и почти `ZeroDowntime`. Те наши ресурсы при изменении, например когда надо будет удалить, а потом поднять, будут производиться не одновременно
    а сначала будет ожидаться когда создастся ресурс, который должен заменить старый, и только потом старый удаляется