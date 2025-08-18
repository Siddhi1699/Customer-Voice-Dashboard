# Customer Voice Dashboard – KPI Definitions

## Dataset Overview
- **Dataset:** `amazon_reviews_books_sample.csv`  
- **Rows:** 9,600 sampled reviews from the Amazon Books dataset.  
- **Columns:** 15 fields including `review_id`, `product_title`, `star_rating`, `review_body`, `helpful_votes`, `verified_purchase`, `review_date`, etc.  
- **Location:** `data/raw/amazon_reviews_books_sample.csv`  

This dataset contains both **structured data** (ratings, votes, verified purchase) and **unstructured data** (review text), which allows analysis of customer feedback and sentiment.

---

## KPI Template
- **File:** `kpi_template.xlsx`  
- **Location:** `data/kpi_template.xlsx`  
- Designed to track all major KPIs for the Customer Voice Dashboard project.  
- Includes the following categories:

### 1. Review Volume
| KPI Name | Definition / Formula |
|----------|--------------------|
| Total Reviews | `COUNT(review_id)` |
| Reviews by Year | `COUNT(review_id) GROUP BY year` |
| Reviews by Verified Purchase | `% of reviews where verified_purchase = Y` |

### 2. Customer Sentiment
| KPI Name | Definition / Formula |
|----------|--------------------|
| Avg. Star Rating | `AVG(star_rating)` |
| Rating Distribution | `% of 1★,2★,3★,4★,5★ ratings` |
| Positive Reviews % | `% of reviews with star_rating ≥ 4` |
| Negative Reviews % | `% of reviews with star_rating ≤ 2` |

### 3. Engagement
| KPI Name | Definition / Formula |
|----------|--------------------|
| Helpful Vote Ratio | `SUM(helpful_votes)/SUM(total_votes)` |
| Avg. Helpful Votes per Review | `AVG(helpful_votes)` |

### 4. Text Insights
| KPI Name | Definition / Formula |
|----------|--------------------|
| Top Keywords in Reviews | Most frequent words in `review_body` |
| Avg. Review Length (words) | `AVG(WORDCOUNT(review_body))` |
| Sentiment Score (NLP) | Sentiment analysis of review text (e.g., VADER/TextBlob) |

### 5. Product Insights
| KPI Name | Definition / Formula |
|----------|--------------------|
| Top 10 Most Reviewed Books | `product_title` with highest `COUNT(review_id)` |
| Top Rated Books | Books with `AVG(star_rating) ≥ 4.5` and ≥ 50 reviews |
| Most Helpful Book | Book with highest `SUM(helpful_votes)` |

