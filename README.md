## 環境構築の手順書

### 0. 環境の前提条件

以下の環境を満たしていることを確認してください。

- Docker がインストールされていること
- 本リポジトリをローカルにクローン済みであること

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

プロジェクト直下に `.env` ファイルを作成し、以下の環境変数を設定します。

```dotenv
MYSQL_ROOT_PASSWORD=supersecretpassword  # MySQL の root ユーザーのパスワード（管理者用）
MYSQL_DATABASE=shopdb  # 作成するデフォルトのデータベース名
MYSQL_USER=user  # MySQL に作成する一般ユーザー名
MYSQL_PASSWORD=password  # 一般ユーザーのパスワード
```

<br>
 
### 4. コンテナを起動する

以下のコマンドを実行して、コンテナを起動します。

```bash
docker-compose up -d
```

以下URLにアクセスして、DBの内容が取得できれば成功です。
- http://localhost:8080/index.php
