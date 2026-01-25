CREATE DATABASE ecommerce;

CREATE TABLE category_name_translation(
   product_category_name VARCHAR(50),
   product_category_name_english VARCHAR(50)
);

CREATE TABLE orders(
   order_id CHAR(32),
   customer_id CHAR(32),
   order_status VARCHAR(30),
   order_purchase_timestamp DATETIME,
   order_approved_at DATETIME,
   order_delivered_carrier_date DATETIME,
   order_delivered_customer_date DATETIME,
   order_estimated_delivery_date DATETIME
);

CREATE TABLE order_reviews(
    review_id CHAR(32),
    order_id CHAR(32),
    review_score TINYINT,
    review_comment_title VARCHAR(50),
    review_comment_message VARCHAR(1000),
    review_creation_date DATETIME,
    review_answer_timestamp DATETIME
);

CREATE TABLE order_payments(
    order_id CHAR(32),
    payment_sequential TINYINT,
    payment_type VARCHAR(20),
    payment_installments TINYINT,
    payment_value DOUBLE
); 

CREATE TABLE order_items(
     order_id CHAR(32),
     order_item_id TINYINT,
     product_id CHAR(32),
     seller_id CHAR(32),
     shipping_limit_date DATETIME,
     price DOUBLE,
     freight_value DOUBLE
);

CREATE TABLE GEOLOCATION(
     geolocation_zip_code_prefix INT,
     geolocation_lat DOUBLE,
     geolocation_lng DOUBLE,
     geolocation_city VARCHAR(50),
     geolocation_state CHAR(2)
);

CREATE TABLE products(
   product_id CHAR(32),
   product_category_name VARCHAR(50),
   product_name_lenght TINYINT,
   product_description_lenght INT,
   product_photos_qty TINYINT,
   product_weight_g INT,
   product_length_cm SMALLINT,
   product_height_cm SMALLINT,
   product_width_cm SMALLINT
);

CREATE TABLE sellers(
    seller_id CHAR(32),
    seller_zip_code_prefix INT,
    seller_city VARCHAR(50),
    seller_state CHAR(2)
);

CREATE TABLE cutsomers(
   customer_id CHAR(32),
   customer_unique_id CHAR(32),
   customer_zip_code_prefix INT,
   customer_city VARCHAR(50),
   customer_state CHAR(2)
);



-- Customers: Unique ID is customer_id
ALTER TABLE customers
ADD PRIMARY KEY (customer_id);

-- Orders: Unique ID is order_id
ALTER TABLE orders
ADD PRIMARY KEY (order_id);

-- Products: Unique ID is product_id
ALTER TABLE products
ADD PRIMARY KEY (product_id);

-- Sellers: Unique ID is seller_id
ALTER TABLE sellers
ADD PRIMARY KEY (seller_id);

-- Category Translation: Unique ID is product_category_name
ALTER TABLE category_name_translation
ADD PRIMARY KEY (product_category_name);

-- Order Items: Composite PK (order_id + item number)
ALTER TABLE order_items
ADD PRIMARY KEY (order_id, order_item_id);

-- Order Payments: Composite PK (order_id + sequence)
ALTER TABLE order_payments
ADD PRIMARY KEY (order_id, payment_sequential);

-- Order Reviews: Composite PK (review_id + order_id)
-- Note: review_id is not unique on its own (same review can tag multiple orders)
ALTER TABLE order_reviews
ADD PRIMARY KEY (review_id, order_id);
