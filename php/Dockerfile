FROM php:8.2-fpm

# MySQL クライアントをインストール
RUN apt-get update \
 && apt-get install -y default-mysql-client

# pdo_mysql ドライバをインストール
RUN docker-php-ext-install pdo_mysql
