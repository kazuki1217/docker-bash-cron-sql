-- 文字コード設定
SET NAMES utf8mb4;

-- テーブル名「categories」を作成（すでに同じ名前のテーブルが存在する場合は作らない）
CREATE TABLE IF NOT EXISTS categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- サンプルデータを追加
INSERT INTO categories (name) VALUES ('肉'), ('野菜'), ('果物'), ('日用品');


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
    -- 肉
    ('豚バラ肉（100g）', 198.00, 100, 1, 0),
    ('鶏もも肉（100g）', 128.00, 150, 1, 0),


    -- 野菜
    ('トマト', 98.00, 300, 2, 0),
    ('キャベツ', 150.00, 200, 2, 0),

    -- 果物
    ('りんご', 120.00, 250, 3, 0),
    ('バナナ', 98.00, 300, 3, 1),

    
    -- 日常品
    ('トイレットペーパー', 398.00, 100, 4, 0),
    ('洗濯洗剤', 298.00, 200, 4, 1)
