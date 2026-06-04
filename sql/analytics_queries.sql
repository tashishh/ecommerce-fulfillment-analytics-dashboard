-- ============================================================
-- File: sql/analytics_queries.sql
-- Purpose: Business analytics queries for dashboard charts
-- These feed Flask endpoints: monthly-orders, category-revenue,
--   state-delivery, payment-summary, review-delivery
-- ============================================================

USE olist_ecommerce;

-- ════════════════════════════════════════════════════════════
-- SECTION 1: MONTHLY TRENDS
-- Business question: How many orders were placed each month?
-- ════════════════════════════════════════════════════════════

-- Monthly order volume and revenue
SELECT
    order_month,
    COUNT(DISTINCT order_id)    AS total_orders,
    ROUND(SUM(revenue), 2)      AS total_revenue
FROM orders_clean
WHERE order_month IS NOT NULL
GROUP BY order_month
ORDER BY order_month ASC;

-- Monthly orders by year (for year-over-year comparison)
SELECT
    order_year,
    order_month,
    COUNT(DISTINCT order_id) AS total_orders
FROM orders_clean
WHERE order_year IS NOT NULL
GROUP BY order_year, order_month
ORDER BY order_year, order_month;


-- ════════════════════════════════════════════════════════════
-- SECTION 2: CATEGORY REVENUE
-- Business question: Which product categories drive the most revenue?
-- ════════════════════════════════════════════════════════════

-- Top 15 categories by total revenue
SELECT
    product_category,
    COUNT(DISTINCT order_id)        AS total_orders,
    ROUND(SUM(revenue), 2)          AS total_revenue,
    ROUND(AVG(review_score), 2)     AS avg_review_score,
    ROUND(AVG(freight_value), 2)    AS avg_freight_value
FROM orders_clean
WHERE product_category IS NOT NULL
GROUP BY product_category
ORDER BY total_revenue DESC
LIMIT 15;

-- Category with highest average freight cost
SELECT
    product_category,
    ROUND(AVG(freight_value), 2)    AS avg_freight,
    ROUND(AVG(freight_ratio), 4)    AS avg_freight_ratio,
    COUNT(DISTINCT order_id)        AS total_orders
FROM orders_clean
WHERE product_category IS NOT NULL
GROUP BY product_category
ORDER BY avg_freight DESC
LIMIT 10;


-- ════════════════════════════════════════════════════════════
-- SECTION 3: DELIVERY PERFORMANCE BY STATE
-- Business question: Which states have the worst delivery times?
-- ════════════════════════════════════════════════════════════

-- Delivery performance per customer state
SELECT
    customer_state,
    COUNT(DISTINCT order_id)    AS total_orders,
    ROUND(AVG(delivery_days), 2) AS avg_delivery_days,
    ROUND(
        SUM(CASE WHEN is_late_delivery = 'Yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*), 2
    )                           AS late_delivery_rate_pct
FROM orders_clean
WHERE customer_state IS NOT NULL
GROUP BY customer_state
ORDER BY late_delivery_rate_pct DESC;

-- Top 10 states with worst average delivery time
SELECT
    customer_state,
    ROUND(AVG(delivery_days), 2) AS avg_delivery_days,
    COUNT(DISTINCT order_id)     AS total_orders
FROM orders_clean
WHERE delivery_days IS NOT NULL
GROUP BY customer_state
ORDER BY avg_delivery_days DESC
LIMIT 10;


-- ════════════════════════════════════════════════════════════
-- SECTION 4: REVIEW SCORE vs DELIVERY STATUS
-- Business question: Do late deliveries get lower review scores?
-- ════════════════════════════════════════════════════════════

-- Average review score: late vs on-time
SELECT
    is_late_delivery            AS delivery_status,
    ROUND(AVG(review_score), 2) AS avg_review_score,
    COUNT(DISTINCT order_id)    AS total_orders
FROM orders_clean
WHERE review_score IS NOT NULL
GROUP BY is_late_delivery
ORDER BY is_late_delivery;

-- Review group breakdown by delivery status
SELECT
    is_late_delivery,
    review_group,
    COUNT(*) AS total_orders
FROM orders_clean
WHERE review_group IS NOT NULL
GROUP BY is_late_delivery, review_group
ORDER BY is_late_delivery, review_group;


-- ════════════════════════════════════════════════════════════
-- SECTION 5: PAYMENT BEHAVIOR
-- Business question: Which payment types are most common?
-- ════════════════════════════════════════════════════════════

-- Payment type distribution
SELECT
    dominant_payment_type           AS payment_type,
    COUNT(DISTINCT order_id)        AS total_orders,
    ROUND(SUM(total_payment_value), 2) AS total_payment_value,
    ROUND(AVG(payment_installments), 1) AS avg_installments,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders_clean), 2
    )                               AS pct_of_orders
FROM orders_clean
WHERE dominant_payment_type IS NOT NULL
GROUP BY dominant_payment_type
ORDER BY total_orders DESC;

-- Average order value by payment type
SELECT
    dominant_payment_type,
    ROUND(AVG(total_payment_value), 2) AS avg_order_value,
    ROUND(AVG(payment_installments), 2) AS avg_installments
FROM orders_clean
WHERE dominant_payment_type IS NOT NULL
GROUP BY dominant_payment_type
ORDER BY avg_order_value DESC;


-- ════════════════════════════════════════════════════════════
-- SECTION 6: FREIGHT COST ANALYSIS
-- Business question: How does freight cost vary across categories/states?
-- ════════════════════════════════════════════════════════════

-- Average freight value by customer state
SELECT
    customer_state,
    ROUND(AVG(freight_value), 2)  AS avg_freight,
    ROUND(AVG(freight_ratio), 4)  AS avg_freight_ratio,
    COUNT(DISTINCT order_id)      AS total_orders
FROM orders_clean
WHERE customer_state IS NOT NULL
GROUP BY customer_state
ORDER BY avg_freight DESC;

-- Freight cost by delivery bucket
SELECT
    delivery_bucket,
    ROUND(AVG(freight_value), 2)  AS avg_freight,
    ROUND(AVG(delivery_days), 1)  AS avg_delivery_days,
    COUNT(DISTINCT order_id)      AS total_orders
FROM orders_clean
WHERE delivery_bucket IS NOT NULL
GROUP BY delivery_bucket
ORDER BY avg_delivery_days ASC;