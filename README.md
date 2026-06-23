# E-Commerce Fulfillment & Customer Satisfaction Dashboard

A full-stack analytics project analyzing 96,470 e-commerce orders
from the Olist Brazilian marketplace. Built with Python, SQL, Flask,
Chart.js, Tableau, and AWS S3.

---

## 🎯 Business Questions Answered

1. How many orders were placed each month, and which months show higher activity?
2. Which product categories produce the highest revenue?
3. Which customer states have higher late-delivery rates?
4. Do late deliveries receive lower review scores?
5. Which payment types are most common?
6. How does freight cost vary across categories?

---

## 🛠️ Technology Stack

| Layer | Tools |
|---|---|
| Data Cleaning | Python, Pandas |
| Visualization (BI) | Tableau |
| Database | MySQL |
| Backend API | Python, Flask, Flask-CORS |
| Frontend Dashboard | HTML, CSS, JavaScript, Chart.js |
| Cloud Hosting | AWS S3 (static frontend) |
| Version Control | Git, GitHub |

---

## 📊 Key Findings

- **Late deliveries score 2.20 vs 4.18** for on-time deliveries —
  a direct link between logistics and customer satisfaction
- **Health & Beauty** is the top revenue category at R$1.41M
- **Credit card** dominates payments at 73% of all orders
- **Northern states** (AM, RR, AP) have the highest late delivery rates
- **Peak order month** was November 2017

---

## 🗂️ Project Structure

```
ecommerce-fulfillment-analytics-dashboard/
├── data/
│ ├── raw/ # Original Kaggle CSV files (not on GitHub)
│ └── cleaned/ # Cleaned and feature-engineered dataset
├── analysis/ # Python notebooks: inspection, cleaning,
│ # joining, feature engineering, EDA
├── sql/ # Schema, data load, validation, queries, views
├── backend/ # Flask API (app.py, db_config.py)
├── frontend/ # HTML, CSS, JavaScript dashboard
├── tableau/ # Packaged Tableau workbook and screenshots
├── aws/ # S3 deployment notes
├── docs/ # Project overview, data dictionary,
│ # backend plan, demo script, testing checklist
└── screenshots/ # Evidence from each project stage
```

---


---

## 🚀 Setup Instructions

### 1. Clone the Repository
```bash
git clone https://github.com/tashishh/ecommerce-fulfillment-analytics-dashboard.git
cd ecommerce-fulfillment-analytics-dashboard
```

### 2. Set Up the Database
```bash
# Import schema and data
mysql -u root -p < sql/schema.sql
mysql -u root -p olist_ecommerce < sql/data_load.sql
mysql -u root -p olist_ecommerce < sql/views.sql
```

### 3. Configure Backend Credentials
```bash
# Create backend/.env with your MySQL credentials
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=olist_ecommerce
```

### 4. Run the Flask Backend
```bash
cd backend
pip install -r requirements.txt
python app.py
# Runs on http://127.0.0.1:5000
```

### 5. Open the Frontend
Open `frontend/index.html` with Live Server in VS Code
(`http://localhost:5500`)

---

## 📡 API Endpoints

| Endpoint | Returns |
|---|---|
| `GET /api/health` | Server status |
| `GET /api/kpis` | 5 KPI values |
| `GET /api/monthly-orders` | Monthly order trends |
| `GET /api/category-revenue` | Top 15 categories by revenue |
| `GET /api/state-delivery` | Delivery performance by state |
| `GET /api/payment-summary` | Payment type breakdown |
| `GET /api/review-delivery` | Review score vs delivery status |

---

## ☁️ AWS Deployment

- **Frontend** hosted on AWS S3 static website hosting
- **Backend** currently runs locally (localhost:5000)
- **Limitation:** API calls return blank values from the S3 URL
  because the Flask backend is not publicly hosted
- **Future plan:** Deploy Flask to EC2, MySQL to RDS

---

## ⚠️ Limitations

- Dataset covers 2016–2018 only — no real-time data
- Backend requires local MySQL and Flask to run
- No authentication or access control
- Tableau workbook requires Tableau Desktop or Tableau Public to open

---

## 🔮 Future Improvements

- Deploy Flask backend to AWS EC2
- Move MySQL database to AWS RDS
- Add scheduled ETL for data refresh
- Add seller performance analysis
- Add product-level drill-down filters

---

## 📁 Dataset

[Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
— ~100,000 orders with payments, reviews, products, customers, and sellers.
