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

    // SQLを実行
    $sql = "
        SELECT
            p.id,
            p.name,
            p.price,
            p.stock,
            c.name AS category_name
        FROM products p
        LEFT JOIN categories c ON p.category_id = c.id
    ";

    $stmt = $pdo->query($sql);
    $products = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo "<h1>Products</h1>";
    echo "<table border='1' cellspacing='0' cellpadding='5'>";
    echo "<tr>
            <th>ID</th>
            <th>商品名</th>
            <th>価格</th>
            <th>在庫</th>
            <th>カテゴリ</th>
          </tr>";

    foreach ($products as $row) {
        $category = $row['category_name'] ?? '未分類';
        echo "<tr>
                <td>{$row['id']}</td>
                <td>{$row['name']}</td>
                <td>¥{$row['price']}</td>
                <td>{$row['stock']}</td>
                <td>{$category}</td>
              </tr>";
    }

    echo "</table>";

} catch (PDOException $e) {
    echo "Retrying DB connection...<br>";
    echo $e->getMessage();
}
