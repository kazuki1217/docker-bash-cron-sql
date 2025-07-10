<?php
$host = 'mysql';  // サービス名
$db   = 'shopdb';  // データベース名
$user = getenv('MYSQL_USER');  // ユーザの名前
$pass = getenv('MYSQL_PASSWORD');  // ユーザのパスワード

$dsn = "mysql:host=$host;dbname=$db;charset=utf8mb4";

try {
    // MySQL に接続
    $pdo = new PDO($dsn, $user, $pass);

    // PDOのエラーモードを「例外を投げる」に設定
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // 商品の在庫状況を取得
    $sql = "
        SELECT
            p.id,
            p.name,
            p.price,
            p.stock,
            p.discontinued,
            p.discontinued_at,
            p.created_at,
            p.updated_at,
            c.name AS category_name
        FROM products p
        LEFT JOIN categories c ON p.category_id = c.id
        ORDER BY p.id
    ";

    $stmt = $pdo->query($sql);
    $products = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo '<!DOCTYPE html>';
    echo '<html lang="ja">';
    echo '<head>';
    echo '<meta charset="UTF-8">';
    echo '<meta name="viewport" content="width=device-width, initial-scale=1.0">';
    echo '<title>商品一覧</title>';
    echo '<link rel="stylesheet" href="/style.css">';
    echo '</head>';
    echo '<body>';

    echo "<h1>商品一覧</h1>";

    if (empty($products)) {
        echo "<p>商品データがありません。</p>";
    } else {
        echo "<table>";
        echo "<tr>
                <th>ID</th>
                <th>商品名</th>
                <th>価格</th>
                <th>在庫</th>
                <th>カテゴリ</th>
                <th>作成日時</th>
                <th>更新日時</th>
                <th>廃番</th>
                <th>廃番日時</th>
              </tr>";

        foreach ($products as $row) {
            $category = $row['category_name'] ?? '未分類';
            $priceFormatted = number_format($row['price'], 2);
            $discontinued = $row['discontinued'] ? '廃番' : '-';
            $discontinuedClass = $row['discontinued'] ? 'discontinued' : 'discontinued inactive';
            $discontinuedAt = $row['discontinued_at'] ?? '-';
            $createdAt = $row['created_at'] ?? '-';
            $updatedAt = $row['updated_at'] ?? '-';

            echo "<tr>
                    <td>{$row['id']}</td>
                    <td>{$row['name']}</td>
                    <td class='price'>¥{$priceFormatted}</td>
                    <td>{$row['stock']}</td>
                    <td>{$category}</td>
                    <td>{$createdAt}</td>
                    <td>{$updatedAt}</td>
                    <td class='{$discontinuedClass}'>{$discontinued}</td>
                    <td>{$discontinuedAt}</td>
                  </tr>";
        }

        echo "</table>";
    }

    echo '</body>';
    echo '</html>';
} catch (PDOException $e) {
    echo $e->getMessage();
}
