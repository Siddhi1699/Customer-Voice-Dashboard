-- Total reviews
SELECT COUNT(*) AS total_reviews FROM reviews_clean;

-- Reviews by year
SELECT year, COUNT(*) AS reviews_per_year
FROM reviews_clean
GROUP BY year
ORDER BY year;

-- Average star rating
SELECT AVG(star_rating) AS avg_rating FROM reviews_clean;

-- Reviews by verified purchase
SELECT verified_purchase, COUNT(*) AS count_reviews
FROM reviews_clean
GROUP BY verified_purchase;

-- Top 10 most reviewed books
SELECT product_title, COUNT(*) AS num_reviews
FROM reviews_clean
GROUP BY product_title
ORDER BY num_reviews DESC
LIMIT 10;

-- Helpful vote ratio per book
SELECT product_title, SUM(helpful_votes)/SUM(total_votes) AS helpful_ratio
FROM reviews_clean
GROUP BY product_title
ORDER BY helpful_ratio DESC
LIMIT 10;
