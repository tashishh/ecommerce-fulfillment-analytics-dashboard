USE olist_ecommerce;

-- CHECK 1: Total row count
SELECT COUNT(*) AS total_rows
FROM orders_clean;

-- CHECK 2: Date range of orders
SELECT
    MIN(order_purchase_timestamp) AS earliest_order,
    MAX(order_purchase_timestamp) AS latest_order
FROM orders_clean;

-- CHECK 3: Null check on critical columns
SELECT
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END)          AS null_order_id,
    SUM(CASE WHEN revenue IS NULL THEN 1 ELSE 0 END)            AS null_revenue,
    SUM(CASE WHEN delivery_days IS NULL THEN 1 ELSE 0 END)      AS null_delivery_days,
    SUM(CASE WHEN product_category IS NULL THEN 1 ELSE 0 END)   AS null_category,
    SUM(CASE WHEN review_score IS NULL THEN 1 ELSE 0 END)       AS null_review_score
FROM orders_clean;

-- CHECK 4: Total revenue
SELECT ROUND(SUM(revenue), 2) AS total_revenue
FROM orders_clean;

-- CHECK 5: Average review score (exclude NULLs — orders with no review)
SELECT ROUND(AVG(review_score), 2) AS avg_review_score
FROM orders_clean
WHERE review_score IS NOT NULL;

-- CHECK 6: Average delivery days
SELECT ROUND(AVG(delivery_days), 2) AS avg_delivery_days
FROM orders_clean
WHERE delivery_days IS NOT NULL;

-- CHECK 7: Late delivery rate
SELECT
    ROUND(
        SUM(CASE WHEN is_late_delivery = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
    2) AS late_delivery_rate_pct
FROM orders_clean;

-- CHECK 8: Distinct customer states
SELECT COUNT(DISTINCT customer_state) AS distinct_states
FROM orders_clean;

-- CHECK 9: Distinct product categories
SELECT COUNT(DISTINCT product_category) AS distinct_categories
FROM orders_clean;

-- CHECK 10: Review group distribution
SELECT review_group, COUNT(*) AS total_orders
FROM orders_clean
WHERE review_group IS NOT NULL
GROUP BY review_group
ORDER BY total_orders DESC;

-- CHECK 11: Delivery bucket distribution
SELECT delivery_bucket, COUNT(*) AS total_orders
FROM orders_clean
WHERE delivery_bucket IS NOT NULL
GROUP BY delivery_bucket
ORDER BY total_orders DESC;

-- CHECK 12: Payment type distribution
SELECT
    dominant_payment_type,
    COUNT(*) AS total_orders,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders_clean), 2) AS pct
FROM orders_clean
GROUP BY dominant_payment_type
ORDER BY total_orders DESC;

-- CHECK 13: Sample 5 rows — visual check
SELECT
    order_id,
    order_month,
    customer_state,
    product_category,
    revenue,
    delivery_days,
    is_late_delivery,
    review_score,
    review_group,
    delivery_bucket
FROM orders_clean
LIMIT 5;