# E-Commerce Fulfillment and Customer Satisfaction Analytics Dashboard

A full-stack data analytics project analyzing ~100,000 Brazilian e-commerce orders
to understand delivery performance, freight cost, product category revenue, payment
behavior, and customer satisfaction patterns.

---

## Dataset

**Brazilian E-Commerce Public Dataset by Olist**
- Source: [Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
- Size: ~100,000 orders across 9 CSV files
- Coverage: 2016–2018, multiple Brazilian states

To run this project, download the dataset from Kaggle and place the CSV files in `data/raw/`.

---

## Technology Stack

| Layer | Tools |
|-------|-------|
| Data Cleaning & EDA | Python, Pandas, Matplotlib |
| Database | MySQL (local) |
| Backend API | Flask, Flask-CORS |
| Frontend Dashboard | HTML, CSS, JavaScript, Chart.js |
| Business Intelligence | Tableau Public |
| Cloud | AWS S3 (static hosting) |
| Version Control | Git, GitHub |

---

## Project Structure
```
ecommerce-fulfillment-analytics-dashboard/
├── data/
│ ├── raw/ # Original Kaggle CSVs (not committed — see Dataset section)
│ └── cleaned/ # Cleaned and Tableau-ready CSVs
├── analysis/ # Jupyter notebooks: inspection, cleaning, joining, EDA
├── sql/ # Schema, data load, validation, analytics queries, views
├── backend/ # Flask API app, db config, requirements
├── frontend/ # HTML, CSS, JavaScript, Chart.js dashboard
├── tableau/ # Packaged workbook and screenshots
├── aws/ # S3 deployment notes
├── docs/ # Project overview, data dictionary, plans, demo script
└── screenshots/ # Evidence from each project stage
```

---

## Business Questions Answered

1. How many orders were placed each month, and which months show higher activity?
2. Which product categories produce the highest revenue and order volume?
3. Which customer states show higher late-delivery rates or longer delivery times?
4. Do late deliveries receive lower review scores than on-time deliveries?
5. Which payment types are used most often, and how do they relate to order value?
6. How does freight cost vary across states, categories, or order value ranges?

---

## Planned Workflow

`Raw Data` → `Python Cleaning` → `Feature Engineering` → `EDA` →
`Tableau Dashboard` → `SQL Layer` → `Flask API` → `Web Dashboard` → `AWS Deployment`

---

## Key Metric Definitions

- **Revenue** = `price + freight_value` (consistent across Python, SQL, Flask, Tableau, and frontend)
- **Late Delivery** = order delivered after `order_estimated_delivery_date`
- **Delivery Days** = days from purchase timestamp to delivered customer date

---

## Status

🔄 In Progress — Day 2 of 20

---

