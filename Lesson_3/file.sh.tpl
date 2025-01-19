#!/bin/bash
touch file.txt
cat <<EOF > file.txt
Owner ${f_name} ${l_name}

# Обрабатываем массив names
EOF

for arg in "${names[@]}"; do
  echo "Hello ${arg} from ${f_name} ${l_name}" >> file.txt
done