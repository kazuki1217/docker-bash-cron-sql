-- テーブル名「categories」を作成（すでに同じ名前のテーブルが存在する場合は作らない）
CREATE TABLE IF NOT EXISTS categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- サンプルデータを追加
INSERT INTO categories (name) VALUES ('Fruits'), ('Vegetables');


-- テーブル名「products」を作成（すでに同じ名前のテーブルが存在する場合は作らない）
CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY, -- 商品ID（PK）
    name VARCHAR(255) NOT NULL UNIQUE, -- 商品名（最大255文字、値必須、一意にする）
    price DECIMAL(10,2), -- 商品の価格（整数8桁 + 少数2桁まで）
    stock INT NOT NULL, -- 在庫数（値必須）
    category_id INT, -- カテゴリーID（FK）
    discontinued BOOLEAN DEFAULT 0, -- 廃番フラグ（0：現役、1：廃番）
    discontinued_at DATETIME DEFAULT NULL, -- 廃番にした日時
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- 作成日時
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,-- 更新日時
    FOREIGN KEY (category_id) REFERENCES categories(id) -- category_id と categories.id を紐づける
);

-- サンプルデータを追加
INSERT INTO products (name, price, stock, category_id, discontinued)
VALUES
    ('Apple', 100.00, 10, 1, 0),
    ('Banana', 50.00, 20, 1, 0),
    ('Carrot', 30.00, 50, 2, 1);
