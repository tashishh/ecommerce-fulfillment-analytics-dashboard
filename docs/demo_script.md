# Demo Script — 3 to 5 Minute Presentation

## 1. Introduce the Business Problem (30 seconds)
"This project analyzes 96,470 e-commerce orders from Olist,
a Brazilian marketplace. The goal was to understand fulfillment
performance and customer satisfaction — specifically: which
regions have late deliveries, which categories generate the
most revenue, and whether late deliveries affect review scores."

## 2. Show the Dataset (30 seconds)
"The Olist dataset has 9 connected CSV files — orders,
customers, products, payments, reviews, and more. I selected
the 7 most relevant tables and joined them in Python after
careful cleaning to avoid row multiplication."

## 3. Show One Cleaning Decision (30 seconds)
"I kept only orders with status 'delivered' for delivery
analysis because delivery time cannot be calculated for
cancelled or pending orders. This reduced the dataset from
~112,000 to ~96,000 rows."

## 4. Show One SQL View + Matching API Endpoint (45 seconds)
"I created reusable SQL views to keep the Flask backend clean.
For example, the kpi_summary view calculates all 5 KPIs in one
query. The /api/kpis endpoint queries this view and returns JSON
in under 100ms."

## 5. Show the Web Dashboard (45 seconds)
"The web dashboard fetches live data from Flask. KPI cards,
a monthly trend line chart, category revenue bar chart, payment
doughnut, review comparison, and a full state delivery table —
all driven by real API data."

## 6. Show the Tableau Dashboard (45 seconds)
"Tableau gives the business view — interactive filters by state,
category, and month. The strongest finding: late deliveries
receive an average review score of 2.20 vs 4.18 for on-time
deliveries. That's a direct link between logistics and
customer satisfaction."

## 7. Close with AWS, Limitations & Improvements (30 seconds)
"The frontend is hosted on AWS S3. The backend currently runs
locally — the next step would be EC2 for the Flask API and RDS
for MySQL. Future improvements include automated data refresh
and seller-level performance analysis."