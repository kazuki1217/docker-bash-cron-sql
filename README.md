## 何をしているのか

商品の在庫状況を分単位で自動更新する機能を実装しました。

php/scripts/stock_in.csv ファイルに入庫した商品の情報が入り、php/scripts/stock_out.csv ファイルに出庫した商品の情報が入ることを想定し、それらの情報をDBに自動で反映する機能を実装しました。在庫状況を確認する方法は2種類で、ブラウザからの確認と、 php/scripts/stock_report.csv ファイルからの確認が可能です。

<details>
<summary>使用技術</summary>

- Nginx
- PHP
- Bash
- MySQL
- phpMyAdmin

</details>

<br>

## 環境構築の手順書

### 0. 環境の前提条件

以下の環境を満たしていることを確認してください。

- Docker がインストールされていること
- 本リポジトリをローカルにクローン済みであること
- プロジェクトのルートディレクトリに移動していること

<br>

### 1. プロジェクトの所有者を自分に変更

以下のコマンドを実行し、所有者を自分に変更します。

```
sudo chown -R $USER:$USER .
chmod -R 744 .
```

<br>

### 2. ログファイルを作成する

以下のコマンドを実行し、`./nginx/logs/access.log` と `./nginx/logs/error.log` の2つのログファイルを作成します。

```bash
mkdir -p ./nginx/logs
touch ./nginx/logs/access.log
touch ./nginx/logs/error.log
```

<br>

### 3. `.env` ファイルを作成する

以下のコマンドを実行し、プロジェクト直下と ./php/ 配下に `.env` ファイルを設定します。

```bash
echo "MYSQL_ROOT_PASSWORD=supersecretpassword
MYSQL_DATABASE=shopdb
MYSQL_USER=user
MYSQL_PASSWORD=password" > .env

echo "MYSQL_ROOT_PASSWORD=supersecretpassword
MYSQL_DATABASE=shopdb
MYSQL_USER=user
MYSQL_PASSWORD=password" > ./php/.env
```

<br>
 
### 4. コンテナを起動する

以下のコマンドを実行して、コンテナを起動します。

```bash
docker-compose up -d
```

以下URLにアクセスして、DBの内容が取得できれば成功です。
- http://localhost:8080/index.php

<br><br>

## 動作確認に用いるコマンド

入庫した商品の情報をDBに反映するコマンド
```
docker compose exec php /scripts/stock_in_import.sh
```
出庫した商品の情報をDBに反映するコマンド
```
docker compose exec php /scripts/stock_out_update.sh
```
在庫状況を stock_report.csv ファイルに出力するコマンド
```
docker compose exec php /scripts/stock_report.sh
```
cron を起動するコマンド
```
docker compose exec php service cron start
```
cron で実行ログを表示するコマンド
```
docker compose exec php cat /var/log/cron.log
```


