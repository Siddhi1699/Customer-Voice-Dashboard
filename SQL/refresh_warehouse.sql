DELIMITER //

CREATE PROCEDURE refresh_warehouse()
BEGIN
    -- Step 1: clear existing data
    DELETE FROM fact_reviews;
    DELETE FROM dim_date;
    DELETE FROM dim_product;
    DELETE FROM dim_customer;

    -- Populate fact_reviews from the latest raw data
    INSERT INTO fact_reviews (
        review_id,
        date_id,
        product_id,
        customer_id,
        star_rating,
        helpful_votes,
        total_votes,
        helpful_ratio,
        vine,
        verified_purchase,
        review_length
    )
    SELECT 
        review_id,
        STR_TO_DATE(review_date, '%d-%m-%Y') AS date_id,
        product_id,
        customer_id,
        CAST(star_rating AS UNSIGNED) AS star_rating,
        CAST(helpful_votes AS UNSIGNED) AS helpful_votes,
        CAST(total_votes AS UNSIGNED) AS total_votes,
        CASE WHEN total_votes = 0 THEN 0 ELSE helpful_votes / total_votes END AS helpful_ratio,
        vine,
        verified_purchase,
        review_length
    FROM reviews_clean
    WHERE review_id IS NOT NULL;

-- Populate dim_date from reviews_clean
    INSERT INTO dim_date (date_id, year, month, day, day_of_week)
    SELECT DISTINCT
        STR_TO_DATE(review_date, '%d-%m-%Y') AS date_id,
        YEAR(STR_TO_DATE(review_date, '%d-%m-%Y')) AS year,
        MONTH(STR_TO_DATE(review_date, '%d-%m-%Y')) AS month,
        DAY(STR_TO_DATE(review_date, '%d-%m-%Y')) AS day,
        DAYNAME(STR_TO_DATE(review_date, '%d-%m-%Y')) AS day_of_week
    FROM reviews_clean
    WHERE review_date IS NOT NULL;
-- Populate dim_product from reviews_clean
    INSERT INTO dim_product (product_id, product_parent, product_title, product_category)
    SELECT DISTINCT
        product_id,
        product_parent,
        product_title,
        product_category
    FROM reviews_clean
    WHERE product_id IS NOT NULL;
-- Populate dim_customer from reviews_clean
    INSERT INTO dim_customer (customer_id, marketplace)
    SELECT DISTINCT
        customer_id,
        marketplace
    FROM reviews_clean
    WHERE customer_id IS NOT NULL;
END;
//

DELIMITER ;

CALL refresh_warehouse();
