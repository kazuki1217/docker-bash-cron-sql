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
    $stmt = $pdo->query("SELECT * FROM products");

    // 取得結果をすべて配列に格納
    $products = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo "<h1>Products</h1>";
    echo "<ul>";

    // 配列の中身を 1件ずつ取り出して表示
    foreach ($products as $row) {
        echo "<li>{$row['id']}: {$row['name']} - ¥{$row['price']}</li>";
    }
    echo "</ul>";

    exit;
} catch (PDOException $e) {
    echo "Retrying DB connection...<br>";
    echo $e->getMessage();
}
