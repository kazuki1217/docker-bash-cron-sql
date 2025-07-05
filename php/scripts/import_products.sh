#!/bin/bash

echo "Start import..."

# MySQL サーバに接続して、INSERT文を実行
mysql -h mysql -u user -ppassword shopdb -e \
  "INSERT INTO products (id, name, price, stock) VALUES (1, 'Test Product', 123.45, 100);"

echo "Finished."
