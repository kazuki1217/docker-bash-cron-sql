#!/bin/bash

# /etc/.env の中に書いてある設定を読み込む
set -a
. /etc/.env 
set +a

# 在庫状況CSVのパス
REPORT_FILE="/scripts/stock_report.csv"

# ヘッダを書き込む
echo "id,name,price,stock,category_name,created_at,updated_at,discontinued,discontinued_at" > $REPORT_FILE

# データ追記
mysql -h mysql -u ${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DATABASE} -B -N -e "
    SELECT
        CONCAT_WS(',',
            p.id,
            p.name,
            FORMAT(p.price, 2),
            p.stock,
            IFNULL(c.name, '未分類'),
            IFNULL(p.created_at, '-'),
            IFNULL(p.updated_at, '-'),
            IF(p.discontinued = 1, '廃番', '-'),
            IFNULL(p.discontinued_at, '-')
        )
    FROM products p
    LEFT JOIN categories c ON p.category_id = c.id
    ORDER BY p.id;
" >> $REPORT_FILE

echo "[INFO] CSVレポート作成完了: $REPORT_FILE"
