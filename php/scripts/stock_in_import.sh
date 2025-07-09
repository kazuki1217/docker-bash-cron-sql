#!/bin/bash

# /etc/.env の中に書いてある設定を読み込む
set -a
. /etc/.env
set +a

# logger.sh を読み込む
. /scripts/logger.sh

log INFO "============================================================"

# 入庫情報CSVファイルのパス
CSV_FILE="/scripts/stock_in.csv"

# CSVファイルが存在しない場合はエラーを表示して終了
if [ ! -f $CSV_FILE ]; then
    log ERROR "CSVファイルが存在しません: $CSV_FILE"
    exit 1
fi

# ファイル末尾に改行を入れて read が最後の行を読み込めるようにする
echo >> "$CSV_FILE"

log INFO "入庫情報の反映を開始"

# CSVの1行目（ヘッダー行）を飛ばして、2行目以降を1行ずつ読み込む
tail -n +2 $CSV_FILE | while IFS=',' read -r name price stock category_id discontinued
do
    # 空行はスキップ
    if [ -z "$name" ]; then
        continue
    fi

    # 仕入れた商品情報を登録（name が既に存在する場合は更新し、在庫は加算）
    mysql --default-character-set=utf8mb4 -h mysql -u ${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DATABASE} -e "
        INSERT INTO products (name, price, stock, category_id, discontinued, discontinued_at)
        VALUES (
            '$name',
            $price,
            $stock,
            $category_id,
            $discontinued,
            IF($discontinued=1, NOW(), NULL)
        )
        ON DUPLICATE KEY UPDATE
            price = VALUES(price),
            stock = stock + VALUES(stock),
            category_id = VALUES(category_id),
            discontinued = VALUES(discontinued),
            discontinued_at = IF(VALUES(discontinued)=1, NOW(), NULL)
    "
    log INFO "$name の登録が完了"
done

# CSVを空にする
> "$CSV_FILE"

log INFO "CSVファイルを空にしました: $CSV_FILE"
log INFO "入庫情報の反映を終了"
