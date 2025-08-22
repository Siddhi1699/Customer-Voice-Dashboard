-- 1. Total Reviews : Gives total number of reviews in your dataset.
CREATE OR REPLACE VIEW vw_total_reviews AS
SELECT COUNT(*) AS total_reviews
FROM fact_reviews;


-- 2. Reviews by Year : Tracks review trends over time.
CREATE OR REPLACE VIEW vw_reviews_by_year AS
SELECT d.year, COUNT(f.review_id) AS num_reviews
FROM fact_reviews f
JOIN dim_date d ON f.date_id = d.date_id
GROUP BY d.year
ORDER BY d.year;


-- 3. Reviews by Verified Purchase % : Shows proportion of verified vs non-verified reviews.
CREATE OR REPLACE VIEW vw_reviews_verified AS
SELECT 
    SUM(CASE WHEN verified_purchase = 'Yes' THEN 1 ELSE 0 END) AS verified_reviews,
    SUM(CASE WHEN verified_purchase = 'No' THEN 1 ELSE 0 END) AS non_verified_reviews,
    COUNT(*) AS total_reviews,
    ROUND(SUM(CASE WHEN verified_purchase = 'Yes' THEN 1 ELSE 0 END)/COUNT(*)*100,2) AS verified_pct
FROM fact_reviews;

-- 4. Average Star Rating : Overall product rating
CREATE OR REPLACE VIEW vw_avg_star_rating AS
SELECT AVG(star_rating) AS avg_rating
FROM fact_reviews;

-- 5. Rating Distribution % : Shows % of 1★, 2★, … 5★ reviews.
CREATE OR REPLACE VIEW vw_rating_distribution AS
SELECT star_rating, COUNT(*) AS num_reviews,
    ROUND(COUNT(*) / (SELECT COUNT(*) FROM fact_reviews) * 100,2) AS pct_reviews
FROM fact_reviews
GROUP BY star_rating
ORDER BY star_rating;

-- 6. Positive Reviews %: Measures customer satisfaction trends.
CREATE OR REPLACE VIEW vw_positive_reviews AS
SELECT
    ROUND(SUM(CASE WHEN star_rating >= 4 THEN 1 ELSE 0 END)/COUNT(*)*100,2) AS positive_pct
FROM fact_reviews;

-- 7. Negative Reviews %: Measures customer satisfaction trends.
CREATE OR REPLACE VIEW vw_negative_reviews AS
SELECT
    ROUND(SUM(CASE WHEN star_rating <= 2 THEN 1 ELSE 0 END)/COUNT(*)*100,2) AS negative_pct
FROM fact_reviews;

-- 8. Helpful Vote Ratio : Shows how helpful reviews are perceived.
CREATE OR REPLACE VIEW vw_helpful_ratio AS
SELECT
    ROUND(SUM(helpful_votes)/NULLIF(SUM(total_votes),0),2) AS helpful_ratio
FROM fact_reviews;

-- 9. Avg. Helpful Votes per Review
CREATE OR REPLACE VIEW vw_helpful_votes AS
SELECT
    ROUND(AVG(helpful_votes),2) AS avg_helpful_votes
FROM fact_reviews;

-- 10. Top 10 Most Reviewed Books : Quickly identify popular products.
CREATE OR REPLACE VIEW vw_top_10_products AS
SELECT p.product_title, COUNT(f.review_id) AS num_reviews, ROUND(AVG(f.star_rating),2) AS avg_rating
FROM fact_reviews f
JOIN dim_product p ON f.product_id = p.product_id
GROUP BY p.product_title
ORDER BY num_reviews DESC
LIMIT 10;

-- 11. Top Rated Books (avg rating >= 4.5 and >=50 reviews) : Highlights products with high ratings and enough reviews.
CREATE OR REPLACE VIEW vw_top_rated_books AS
SELECT p.product_title, COUNT(f.review_id) AS num_reviews, ROUND(AVG(f.star_rating),2) AS avg_rating
FROM fact_reviews f
JOIN dim_product p ON f.product_id = p.product_id
GROUP BY p.product_title
HAVING avg_rating >= 4.5 AND num_reviews >= 50
ORDER BY avg_rating DESC;
