#!/bin/bash

# Создаём файл
touch file.txt
cat <<EOF > file.txt
Owner ${f_name} ${l_name}
EOF

%{ for arg in names ~}
echo "Hello ${arg} from ${f_name} ${l_name}" >> file.txt
%{ endfor ~}