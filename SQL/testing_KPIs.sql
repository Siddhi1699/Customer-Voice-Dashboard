-- View
SELECT * FROM vw_total_reviews;

-- Raw check
SELECT COUNT(*) AS total_reviews FROM fact_reviews;

-- View
SELECT * FROM vw_reviews_by_year;

-- Raw check (pick 2020 as example)
SELECT d.year, COUNT(*) AS total_reviews
FROM fact_reviews f
JOIN dim_date d ON f.date_id = d.date_id
WHERE d.year = 2005
GROUP BY d.year;

-- View
SELECT * FROM vw_reviews_verified;

-- Raw check
SELECT 
    SUM(CASE WHEN f.verified_purchase = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) 
    AS pct_verified
FROM fact_reviews f;

-- View
SELECT * FROM vw_avg_star_rating;

-- Raw check
SELECT ROUND(AVG(f.star_rating), 2) AS avg_star_rating
FROM fact_reviews f;

-- View
SELECT * FROM vw_top_10_products LIMIT 10;

-- Raw check
SELECT p.product_id, p.product_title, COUNT(*) AS total_reviews
FROM fact_reviews f
JOIN dim_product p ON f.product_id = p.product_id
GROUP BY p.product_id, p.product_title
ORDER BY total_reviews DESC
LIMIT 10;

-- View
SELECT * FROM vw_rating_distribution;

-- Raw check
SELECT f.star_rating, COUNT(*) * 100.0 / (SELECT COUNT(*) FROM fact_reviews) AS pct_reviews
FROM fact_reviews f
GROUP BY f.star_rating;

-- View
SELECT * FROM vw_helpful_ratio;

-- Raw check
SELECT ROUND(AVG(f.helpful_votes / NULLIF(f.total_votes, 0)), 2) AS helpful_ratio
FROM fact_reviews f
WHERE f.total_votes > 0;




