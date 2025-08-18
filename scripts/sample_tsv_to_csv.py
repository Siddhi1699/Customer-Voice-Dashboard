import pandas as pd

# Input file (your downloaded dataset)
INPUT_FILE = "amazon_reviews_us_Books_v1_02.tsv"

# Output file (clean, smaller dataset for Excel/Power BI/SQL)
OUTPUT_FILE = "amazon_reviews_books_sample.csv"

# Amazon Review Schema (15 columns)
columns = [
    "marketplace", "customer_id", "review_id", "product_id", "product_parent",
    "product_title", "product_category", "star_rating", "helpful_votes", "total_votes",
    "vine", "verified_purchase", "review_headline", "review_body",
    "review_date"
]


# Step 1: Read in chunks (to handle 3GB file without memory crash)
reader = pd.read_csv(
    INPUT_FILE,
    sep="\t",                # TSV separator
    names=columns,           # enforce schema
    header=0,                # file has a header row
    quoting=3,               # ignore quote errors
    on_bad_lines="skip",     # skip malformed rows
    chunksize=100000,        # read 100k rows at a time
    dtype=str                # keep everything as text to avoid parsing issues
)

# Step 2: Sample rows from each chunk
sampled_chunks = []
for i, chunk in enumerate(reader):
    try:
        sampled = chunk.sample(n=300, random_state=42)  # sample 300 per chunk
        sampled_chunks.append(sampled)
    except ValueError:
        # small chunks at the end may have fewer than 300 rows
        sampled_chunks.append(chunk)

    print(f"Processed chunk {i+1}")

# Step 3: Combine samples into one DataFrame
final_sample = pd.concat(sampled_chunks)

# Step 4: Save clean CSV
final_sample.to_csv(OUTPUT_FILE, index=False)

print(f"\nDone! Exported {len(final_sample)} rows to {OUTPUT_FILE}")

