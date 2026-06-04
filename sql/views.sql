-- ============================================================
-- File: sql/views.sql
-- Purpose: Reusable views that feed Flask API endpoints
-- Each view maps directly to one API endpoint
-- ============================================================

USE olist_ecommerce;

-- ════════════════════════════════════════════════════════════
-- VIEW 1: kpi_summary
-- Maps to: GET /api/kpis
-- Returns: One row with all dashboard KPI card values
-- ════════════════════════════════════════════════════════════

DROP VIEW IF EXISTS kpi_summary;

CREATE VIEW kpi_summary AS
SELECT
    COUNT(DISTINCT order_id)                                        AS total_orders,
    ROUND(SUM(revenue), 2)                                          AS total_revenue,
    ROUND(AVG(delivery_days), 2)                                    AS avg_delivery_days,
    ROUND(
        SUM(CASE WHEN is_late_delivery = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*), 2
    )                                                               AS late_delivery_rate,
    ROUND(AVG(CASE WHEN review_score IS NOT NULL
               THEN review_score END), 2)                           AS avg_review_score
FROM orders_clean;


-- ════════════════════════════════════════════════════════════
-- VIEW 2: monthly_order_summary
-- Maps to: GET /api/monthly-orders
-- Returns: One row per month with order count and revenue
-- ════════════════════════════════════════════════════════════

DROP VIEW IF EXISTS monthly_order_summary;

CREATE VIEW monthly_order_summary AS
SELECT
    order_month,
    COUNT(DISTINCT order_id)    AS total_orders,
    ROUND(SUM(revenue), 2)      AS total_revenue
FROM orders_clean
WHERE order_month IS NOT NULL
GROUP BY order_month
ORDER BY order_month ASC;


-- ════════════════════════════════════════════════════════════
-- VIEW 3: category_revenue_summary
-- Maps to: GET /api/category-revenue
-- Returns: Top 15 categories by revenue
-- ════════════════════════════════════════════════════════════

DROP VIEW IF EXISTS category_revenue_summary;

CREATE VIEW category_revenue_summary AS
SELECT
    product_category,
    COUNT(DISTINCT order_id)        AS total_orders,
    ROUND(SUM(revenue), 2)          AS total_revenue,
    ROUND(AVG(review_score), 2)     AS avg_review_score
FROM orders_clean
WHERE product_category IS NOT NULL
GROUP BY product_category
ORDER BY total_revenue DESC
LIMIT 15;


-- ════════════════════════════════════════════════════════════
-- VIEW 4: state_delivery_summary
-- Maps to: GET /api/state-delivery
-- Returns: Delivery performance per customer state
-- ════════════════════════════════════════════════════════════

DROP VIEW IF EXISTS state_delivery_summary;

CREATE VIEW state_delivery_summary AS
SELECT
    customer_state,
    COUNT(DISTINCT order_id)        AS total_orders,
    ROUND(AVG(delivery_days), 2)    AS avg_delivery_days,
    ROUND(
        SUM(CASE WHEN is_late_delivery = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*), 2
    )                               AS late_delivery_rate
FROM orders_clean
WHERE customer_state IS NOT NULL
GROUP BY customer_state
ORDER BY late_delivery_rate DESC;


-- ════════════════════════════════════════════════════════════
-- VIEW 5: payment_summary
-- Maps to: GET /api/payment-summary
-- Returns: Payment type distribution and values
-- ════════════════════════════════════════════════════════════

DROP VIEW IF EXISTS payment_summary;

CREATE VIEW payment_summary AS
SELECT
    dominant_payment_type               AS payment_type,
    COUNT(DISTINCT order_id)            AS total_orders,
    ROUND(SUM(total_payment_value), 2)  AS total_payment_value,
    ROUND(AVG(payment_installments), 1) AS avg_installments
FROM orders_clean
WHERE dominant_payment_type IS NOT NULL
  AND dominant_payment_type != ''       
GROUP BY dominant_payment_type
ORDER BY total_orders DESC;


-- ════════════════════════════════════════════════════════════
-- VIEW 6: review_delivery_summary
-- Maps to: GET /api/review-delivery
-- Returns: Avg review score for late vs on-time deliveries
-- ════════════════════════════════════════════════════════════

DROP VIEW IF EXISTS review_delivery_summary;

CREATE VIEW review_delivery_summary AS
SELECT
    is_late_delivery                AS delivery_status,
    ROUND(AVG(review_score), 2)     AS avg_review_score,
    COUNT(DISTINCT order_id)        AS total_orders
FROM orders_clean
WHERE review_score IS NOT NULL
GROUP BY is_late_delivery
ORDER BY is_late_delivery;


-- ════════════════════════════════════════════════════════════
-- VIEW 7: freight_category_summary
-- Maps to: (optional endpoint or Tableau use)
-- Returns: Freight cost breakdown by category
-- ════════════════════════════════════════════════════════════

DROP VIEW IF EXISTS freight_category_summary;

CREATE VIEW freight_category_summary AS
SELECT
    product_category,
    ROUND(AVG(freight_value), 2)    AS avg_freight,
    ROUND(AVG(freight_ratio), 4)    AS avg_freight_ratio,
    COUNT(DISTINCT order_id)        AS total_orders
FROM orders_clean
WHERE product_category IS NOT NULL
GROUP BY product_category
ORDER BY avg_freight DESC
LIMIT 15;


-- Test all 7 views
SELECT * FROM kpi_summary;

SELECT * FROM monthly_order_summary LIMIT 5;

SELECT * FROM category_revenue_summary;

SELECT * FROM state_delivery_summary LIMIT 5;

SELECT * FROM payment_summary;

SELECT * FROM review_delivery_summary;

SELECT * FROM freight_category_summary;