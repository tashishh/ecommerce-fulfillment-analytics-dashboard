-- ============================================================
-- Data Load: Import cleaned CSV into orders_clean table
-- Source: data/cleaned/ecommerce_orders_features.csv
-- ============================================================

USE olist_ecommerce;

-- Clear existing data before reload (safe for re-runs)
TRUNCATE TABLE orders_clean;
SET GLOBAL local_infile = 1;
SHOW GLOBAL VARIABLES LIKE 'local_infile';
DESCRIBE orders_clean;

-- Load the CSV
LOAD DATA LOCAL INFILE 'D:/innosp/ecommerce-fulfillment-analytics-dashboard/data/cleaned/ecommerce_orders_features.csv'
INTO TABLE orders_clean
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    order_approved_at,
    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_estimated_delivery_date,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state,
    total_payment_value,
    payment_installments,
    dominant_payment_type,
    review_score,
    review_answer_timestamp,
    order_item_id,
    product_id,
    seller_id,
    shipping_limit_date,
    price,
    freight_value,
    product_category_name,
    product_category,
    delivery_days,
    estimated_delay_days,
    is_late_delivery,
    order_month,
    order_year,
    order_weekday,
    order_hour,
    revenue,
    freight_ratio,
    review_group,
    delivery_bucket
);