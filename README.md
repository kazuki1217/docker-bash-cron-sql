## 何をしているのか

商品の在庫状況を分単位で自動更新する在庫管理システムを実装しました。

php/scripts/stock_in.csv ファイルに入庫した商品の情報が入り、php/scripts/stock_out.csv ファイルに出庫した商品の情報が入ることを想定し、それらの情報をDBに自動で反映する機能を実装しました。在庫状況を確認する方法は2種類で、ブラウザからの確認と、 php/scripts/stock_report.csv ファイルからの確認が可能です。

<details>
<summary>使用技術</summary>

- PHP
- Bash
- MySQL
- phpMyAdmin

</details>

<details>
 <summary>在庫管理を実現するファイル一覧</summary>
 
| ファイル名 | 用途 |
| - | - |
| init.sql | 起動時に、商品カテゴリと商品情報を管理するテーブルを作成し、サンプルデータを登録 |
| stock_in.csv | 入庫した商品情報 |
| stock_in_import.sh | 入庫した商品情報をDBに反映する機能 |
| stock_out.csv | 出庫した商品情報 |
| stock_out_update.sh | 出庫した商品情報をDBに反映する機能 |
| stock_report.csv | DBの在庫状況 |
| stock_report.sh | DBの在庫状況を csvファイルに出力する機能 |
| index.php | 商品の在庫状況をブラウザに表示する機能 |
| crontab | bashスクリプトを毎分自動実行する設定 |

</details>
<br>

## 環境構築の手順書

### 0. 環境の前提条件

以下の環境を満たしていることを確認してください。

- Docker がインストールされていること
- 本リポジトリをローカルにクローン済みであること
- プロジェクトのルートディレクトリに移動していること

<br>


### 1. `.env` ファイルを作成する

以下のコマンドを実行し、プロジェクト直下に `.env` ファイルを設定します。

```bash
echo "MYSQL_ROOT_PASSWORD=supersecretpassword
MYSQL_DATABASE=shopdb
MYSQL_USER=user
MYSQL_PASSWORD=password" > .env
```

<br>
 
### 2. コンテナを起動する

以下のコマンドを実行して、コンテナを起動します。

```bash
docker-compose up -d
```

以下URLにアクセスして、商品一覧画面が表示されると成功です。
- http://localhost:8080/index.php

<details>
 <summary>商品一覧画面のスクリーンショット</summary>

![スクリーンショット 2025-07-10 104932](https://github.com/user-attachments/assets/cfe1ed98-90f9-495e-9b5a-65f73e942ace)

</details>


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
docker compose exec php chown root:root /etc/cron.d/my-cron
docker compose exec php chmod 0644 /etc/cron.d/my-cron
docker compose exec php service cron start
```
cron で実行ログを表示するコマンド
```
docker compose exec php cat /var/log/cron.log
```

<details>
 <summary>ログの内容</summary>

 ```log
cron is working!
[2025-07-10 01:08:05] [INFO] ============================================================
[2025-07-10 01:08:05] [INFO] 入庫情報の反映を開始
[2025-07-10 01:08:05] [INFO] 豚バラ肉(100g) の登録が完了
[2025-07-10 01:08:05] [INFO] 牛肩ロース（100g） の登録が完了
[2025-07-10 01:08:05] [INFO] きゅうり の登録が完了
[2025-07-10 01:08:05] [INFO] オレンジ の登録が完了
[2025-07-10 01:08:05] [INFO] 歯ブラシ の登録が完了
[2025-07-10 01:08:05] [INFO] CSVファイルを空にしました: /scripts/stock_in.csv
[2025-07-10 01:08:05] [INFO] 入庫情報の反映を終了
[2025-07-10 01:08:08] [INFO] ============================================================
[2025-07-10 01:08:08] [INFO] 出庫情報の反映を開始
[2025-07-10 01:08:08] [INFO] 豚バラ肉(100g) の在庫数を更新
[2025-07-10 01:08:08] [INFO] トマト の在庫数を更新
[2025-07-10 01:08:08] [INFO] CSVファイルを空にしました: /scripts/stock_out.csv
[2025-07-10 01:08:08] [INFO] 出庫情報の反映を終了
[2025-07-10 01:08:11] [INFO] ============================================================
[2025-07-10 01:08:11] [INFO] CSVレポート作成完了: /scripts/stock_report.csv
```

</details>
