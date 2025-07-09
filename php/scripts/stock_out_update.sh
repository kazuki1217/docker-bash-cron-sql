#!/bin/bash

# /etc/.env の中に書いてある設定を読み込む
set -a
. /etc/.env
set +a

# logger.sh を読み込む
. /scripts/logger.sh

# 出庫情報CSVのパス
CSV_FILE="/scripts/stock_out.csv"

# CSVが存在しない場合は終了
if [ ! -f $CSV_FILE ]; then
    log ERROR "CSVファイルが存在しません: $CSV_FILE"
    exit 1
fi

# ファイル末尾に改行を入れて read が最後の行を読み込めるようにする
echo >> "$CSV_FILE"

log INFO "出庫情報の反映を開始"

# CSVの1行目（ヘッダー行）を飛ばして、2行目以降を1行ずつ読み込む
tail -n +2 $CSV_FILE | while IFS=',' read -r name stock
do
    # 空行はスキップ
    if [ -z "$name" ]; then
        continue
    fi

    # 在庫状況を更新
    mysql -h mysql -u ${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DATABASE} -e "
        UPDATE products
        SET
            stock = GREATEST(stock - $stock, 0)
        WHERE name = '$name';
    "

    log INFO "$name の在庫数を更新"
done

# CSVを空にする
> $CSV_FILE

log INFO "CSVファイルを空にしました: $CSV_FILE"
log INFO "出庫情報の反映を終了"
