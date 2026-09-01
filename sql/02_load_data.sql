-- ============================================================
-- OLIST E-COMMERCE DATA LOAD
-- Imports the cleaned CSV files into the tables created by
-- 01_create_tables.sql.
--
-- BEFORE RUNNING:
-- 1. Run 01_create_tables.sql first.
-- 2. Place the cleaned CSV files (from data/processed/) inside
--    your MySQL server's secure_file_priv directory.
--    - Find your secure_file_priv path by running:
--          SHOW VARIABLES LIKE 'secure_file_priv';
-- 3. Replace '<SECURE_FILE_PRIV_PATH>' below with that path
--    (e.g. 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/' on
--    Windows, or '/var/lib/mysql-files/' on Linux/macOS).
-- 4. If your MySQL server has local_infile disabled, enable it:
--          SET GLOBAL local_infile = 1;
-- ============================================================

USE olist;

-- Import Customers file
LOAD DATA INFILE '<SECURE_FILE_PRIV_PATH>customers_clean.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(customer_id, customer_unique_id, customer_zip_code_prefix, customer_city, customer_state);

-- Import Products file
LOAD DATA INFILE '<SECURE_FILE_PRIV_PATH>products_clean.csv'
INTO TABLE products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(product_id, product_category_name, @pnl, @pdl, @ppq, @pwg, @plc, @phc, @pwc)
SET
    product_name_lenght = NULLIF(@pnl, ''),
    product_description_lenght = NULLIF(@pdl, ''),
    product_photos_qty = NULLIF(@ppq, ''),
    product_weight_g = NULLIF(@pwg, ''),
    product_length_cm = NULLIF(@plc, ''),
    product_height_cm = NULLIF(@phc, ''),
    product_width_cm = NULLIF(@pwc, '');

-- Import Category file
LOAD DATA INFILE '<SECURE_FILE_PRIV_PATH>category_clean.csv'
INTO TABLE category_translation
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    product_category_name,
    product_category_name_english
);

-- Import Sellers file
LOAD DATA INFILE '<SECURE_FILE_PRIV_PATH>sellers_clean.csv'
INTO TABLE sellers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state
);

-- Import Orders file
LOAD DATA INFILE '<SECURE_FILE_PRIV_PATH>orders_clean.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    order_id,
    customer_id,
    order_status,
    @purchase,
    @approved,
    @carrier,
    @customer,
    @estimated
)
SET
    order_purchase_timestamp = NULLIF(@purchase, ''),
    order_approved_at = NULLIF(@approved, ''),
    order_delivered_carrier_date = NULLIF(@carrier, ''),
    order_delivered_customer_date = NULLIF(@customer, ''),
    order_estimated_delivery_date = NULLIF(@estimated, '');

-- Import Order Items file
LOAD DATA INFILE '<SECURE_FILE_PRIV_PATH>items_clean.csv'
INTO TABLE order_items
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    order_id,
    order_item_id,
    product_id,
    seller_id,
    @shipping_limit,
    @price,
    @freight
)
SET
    shipping_limit_date = NULLIF(@shipping_limit, ''),
    price = NULLIF(@price, ''),
    freight_value = NULLIF(@freight, '');

-- Import Payments file
LOAD DATA INFILE '<SECURE_FILE_PRIV_PATH>payments_clean.csv'
INTO TABLE payments
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    order_id,
    payment_sequential,
    payment_type,
    payment_installments,
    payment_value
);

-- Import Reviews file
LOAD DATA INFILE '<SECURE_FILE_PRIV_PATH>reviews_clean.csv'
INTO TABLE reviews
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    review_id,
    order_id,
    review_score,
    @comment_title,
    @comment_message,
    @creation_date,
    @answer_timestamp
)
SET
    review_comment_title = NULLIF(@comment_title, ''),
    review_comment_message = NULLIF(@comment_message, ''),
    review_creation_date = NULLIF(@creation_date, ''),
    review_answer_timestamp = NULLIF(@answer_timestamp, '');

-- Import Geolocation file
LOAD DATA INFILE '<SECURE_FILE_PRIV_PATH>geolocation_clean.csv'
INTO TABLE geolocation
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    geolocation_zip_code_prefix,
    geolocation_lat,
    geolocation_lng,
    geolocation_city,
    geolocation_state
);

-- ============================================================
-- Verify the data imported correctly
-- ============================================================
SELECT 'customers' AS verify_table, COUNT(*) AS row_count FROM customers
UNION ALL
SELECT 'sellers', COUNT(*) FROM sellers
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'category_translation', COUNT(*) FROM category_translation
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'payments', COUNT(*) FROM payments
UNION ALL
SELECT 'reviews', COUNT(*) FROM reviews
UNION ALL
SELECT 'geolocation', COUNT(*) FROM geolocation;
