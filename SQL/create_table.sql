-- Create database
CREATE DATABASE IF NOT EXISTS customer_voice_dashboard;
USE customer_voice_dashboard;

-- Table for cleaned reviews
CREATE TABLE IF NOT EXISTS reviews_clean (
    review_id VARCHAR(50) PRIMARY KEY,       -- unique identifier
    marketplace VARCHAR(20),
    customer_id VARCHAR(50),                 -- for review frequency analysis
    product_id VARCHAR(50),                  -- for product popularity KPIs
    product_parent VARCHAR(50),
    product_title TEXT,                      -- display in dashboards / top products
    product_category VARCHAR(50),
    star_rating INT,                         -- main KPI
    helpful_votes INT,
    total_votes INT,
    vine ENUM('Yes','No'),
    verified_purchase ENUM('Yes','No'),       -- KPI: verified vs non-verified
    review_headline TEXT,
    review_body TEXT,
    review_date DATE,                        -- for time-based KPIs
    review_length INT,                       -- avg review length KPI
    helpful_ratio FLOAT,                     -- KPI: helpful votes ratio
    clean_review TEXT,                        -- preprocessed review for NLP
    clean_review_headline TEXT,
    clean_review_no_stopwords TEXT            -- for NLP keyword extraction / modeling
);


-- marketplace	
-- customer_id
-- review_id	
-- product_id	
-- product_parent	
-- product_title	
-- product_category	
-- star_rating	
-- helpful_votes	
-- total_votes	vine
-- verified_purchase	
-- review_headline	
-- review_body	
-- review_date	
-- review_length	
-- helpful_ratio	
-- clean_review	
-- clean_review_headline	
-- clean_review_no_stopwords
