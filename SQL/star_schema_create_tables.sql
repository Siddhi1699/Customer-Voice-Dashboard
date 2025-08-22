CREATE TABLE IF NOT EXISTS dim_date (
    date_id DATE PRIMARY KEY,
    year INT,
    month INT,
    day INT
);


CREATE TABLE IF NOT EXISTS dim_product (
    product_id VARCHAR(50) PRIMARY KEY,
    product_title TEXT,
    product_category VARCHAR(50),
    product_parent VARCHAR(50)
);


CREATE TABLE IF NOT EXISTS dim_customer (
    customer_id VARCHAR(50) PRIMARY KEY,
    marketplace VARCHAR(20)
);


CREATE TABLE IF NOT EXISTS fact_reviews (
    review_id VARCHAR(50) PRIMARY KEY,
    product_id VARCHAR(50),
    customer_id VARCHAR(50),
    date_id DATE,
    star_rating INT,
    helpful_votes INT,
    total_votes INT,
    review_length INT,
    helpful_ratio FLOAT,
    vine ENUM('Yes','No'),
    verified_purchase ENUM('Yes','No'),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id),
    FOREIGN KEY (customer_id) REFERENCES dim_customer(customer_id),
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id)
);
