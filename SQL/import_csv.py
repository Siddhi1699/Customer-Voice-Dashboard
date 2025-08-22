import pandas as pd
from sqlalchemy import create_engine

# Load CSV
df = pd.read_csv("data/processed/clean_reviews.csv")

# Connect to MySQL
engine = create_engine("mysql+pymysql://root:Siddhi1611#@localhost:3306/customer_voice_dashboard")

# # Write to SQL table
# df.to_sql("reviews_clean", con=engine, if_exists="replace", index=False)
# print("Data loaded into MySQL successfully!")


# Load first 20 rows
df_preview = pd.read_sql("SELECT * FROM reviews_clean LIMIT 20", engine)
print(df_preview)