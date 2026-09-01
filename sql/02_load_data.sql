-- Before running this script:
-- 1. Download the processed Olist datasets.
-- 2. Place them in the MySQL secure_file_priv directory.
-- 3. Update the file paths below according to your local environment.

-- Import Customers file
LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customers_clean.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(customer_id, customer_unique_id, customer_zip_code_prefix, customer_city, customer_state);

-- Import Products file
LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/products_clean.csv'
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
LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/category_clean.csv'
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
LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/sellers_clean.csv'
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
LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/orders_clean.csv'
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
