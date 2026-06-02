# SQL Design Notes

## Database: olist_ecommerce
## Table: orders_clean

### Why One Wide Table?
The joins were already done in Python (Day 5). Loading one cleaned 
wide table keeps the SQL layer simple and focused on analytics queries.
A normalized schema would be better for production but is not required for this portfolio project.

### Data Type Decisions
- VARCHAR for all IDs — Olist IDs are alphanumeric hashes, not integers
- DECIMAL(10,2) for all money fields — FLOAT causes rounding errors
- TINYINT for review_score — values are only 1-5, saves space
- INT for delivery_days — whole days only, no decimals needed
- VARCHAR(3) for is_late_delivery — stores "Yes" or "No"

### No Primary Key
The table is at the order-item level. One order_id can appear multiple 
times (one row per item). A composite key (order_id + product_id) would 
work but adds complexity not needed for this analytics use case.

### Revenue Definition
revenue = price + freight_value
This definition is consistent across Python, SQL, Tableau, Flask, 
and the frontend dashboard.