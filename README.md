# Customer Voice Dashboard

Transforming raw customer feedback into actionable insights with NLP, Power BI, and Python. This project demonstrates a full pipeline: from cleaning Amazon review data, applying sentiment analysis, to building an interactive dashboard for decision-makers.

## Features:
1. Preprocessing of large-scale customer feedback datasets
2. Sentiment analysis (positive, neutral, negative) using NLP
3. Keyword extraction & word clouds for top topics
4. Interactive dashboard built in Power BI
5. Reproducible codebase with Python & Jupyter


## Setup & Installation:
1. Clone the repo -><br/>
git clone https://github.com/Siddhi1699/Customer-Voice-Dashboard.git<br/>
cd Customer-Voice-Dashboard

2. Create a virtual environment -><br/>
python -m venv venv<br/>
source venv/bin/activate   # Mac/Linux <br/>
venv\Scripts\activate      # Windows<br/>


4. Install dependencies -><br/>
pip install -r requirements.txt

5. Download dataset -><br/>
The raw dataset is too large for GitHub.<br/>
Please download it from: [Amazon Customer Reviews Dataset](https://www.kaggle.com/datasets/cynthiarempel/amazon-us-customer-reviews-dataset?select=amazon_reviews_us_Books_v1_02.tsv)<br/>
Save it inside data/raw/
