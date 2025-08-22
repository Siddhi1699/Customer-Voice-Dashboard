INSERT INTO dim_date (date_id, year, month, day)
SELECT DISTINCT
    STR_TO_DATE(review_date, '%d-%m-%Y') AS date_id,
    YEAR(STR_TO_DATE(review_date, '%d-%m-%Y')) AS year,
    MONTH(STR_TO_DATE(review_date, '%d-%m-%Y')) AS month,
    DAY(STR_TO_DATE(review_date, '%d-%m-%Y')) AS day
FROM reviews_clean
WHERE review_date IS NOT NULL;

SELECT * FROM dim_date ORDER BY date_id LIMIT 10;

-------------------------------

INSERT INTO dim_product (product_id, product_title, product_category, product_parent)
SELECT 
    product_id,
    MAX(product_title) AS product_title,
    MAX(product_category) AS product_category,
    MAX(product_parent) AS product_parent
FROM reviews_clean
GROUP BY product_id;

SELECT * FROM dim_product ORDER BY product_id LIMIT 10;

------------------------------------

INSERT INTO dim_customer (customer_id, marketplace)
SELECT DISTINCT
    customer_id,
    marketplace
FROM reviews_clean
WHERE customer_id IS NOT NULL;

SELECT COUNT(*) AS total_customers FROM dim_customer;
SELECT * FROM dim_customer LIMIT 10;

------------------------------------

INSERT INTO fact_reviews (
    review_id,
    date_id,
    product_id,
    customer_id,
    star_rating,
    helpful_votes,
    total_votes,
    helpful_ratio,
    verified_purchase,
    vine,
    review_length
)
SELECT 
    r.review_id,
    STR_TO_DATE(r.review_date, '%d-%m-%Y') AS date_id,
    r.product_id,
    r.customer_id,
    CAST(r.star_rating AS UNSIGNED) AS star_rating,
    CAST(r.helpful_votes AS UNSIGNED) AS helpful_votes,
    CAST(r.total_votes AS UNSIGNED) AS total_votes,
    CASE WHEN r.total_votes = 0 THEN 0 ELSE r.helpful_votes / r.total_votes END AS helpful_ratio,
    r.verified_purchase,
    r.vine,
    r.review_length
FROM reviews_clean r
WHERE r.review_id IS NOT NULL;

SELECT COUNT(*) AS total_reviews FROM fact_reviews;
SELECT * FROM fact_reviews LIMIT 10;

-------------------------------