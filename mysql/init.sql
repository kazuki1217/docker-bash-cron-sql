-- テーブル名「categories」を作成（すでに同じ名前のテーブルが存在する場合は作らない）
CREATE TABLE IF NOT EXISTS categories (
    id INT AUTO_INCREMENT PRIMARY KEY, -- カテゴリーID（PK）
    name VARCHAR(255) NOT NULL -- カテゴリー名（最大255文字）
);

-- サンプルデータを追加
INSERT INTO categories (name) VALUES ('Fruits'), ('Vegetables');


-- テーブル名「products」を作成（すでに同じ名前のテーブルが存在する場合は作らない）
CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY  KEY, -- 商品ID（PK）
    name VARCHAR(255), -- 商品名（最大255文字）
    price DECIMAL(10,2), -- 商品の価格（整数8桁 + 少数2桁まで）
    stock INT DEFAULT 0, -- 在庫数
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- 作成日時
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,-- 更新日時
    category_id INT, -- カテゴリーID（FK）
    FOREIGN KEY (category_id) REFERENCES categories(id) -- category_id と categories.id を紐づける
);

-- サンプルデータを追加
INSERT INTO products (name, price, stock, category_id) VALUES
    ('Apple', 100.00, 10, 1),
    ('Banana', 50.00, 20, 1),
    ('Carrot', 30.00, 50, 2);
