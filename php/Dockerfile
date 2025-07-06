FROM php:8.2-fpm

# mysql-client、cron、procps (ps コマンド) をインストール
RUN apt-get update \
 && apt-get install -y default-mysql-client cron procps

# pdo_mysql ドライバをインストール
RUN docker-php-ext-install pdo_mysql
