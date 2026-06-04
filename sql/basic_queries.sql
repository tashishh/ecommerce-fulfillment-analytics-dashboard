-- ============================================================
-- File: sql/basic_queries.sql
-- Purpose: Simple KPI queries for dashboard summary cards
-- These feed the /api/kpis Flask endpoint
-- ============================================================

USE olist_ecommerce;

-- ── KPI 1: Total number of orders ──────────────────────────
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM orders_clean;

-- ── KPI 2: Total revenue (price + freight) ─────────────────
SELECT ROUND(SUM(revenue), 2) AS total_revenue
FROM orders_clean;

-- ── KPI 3: Average delivery days ───────────────────────────
SELECT ROUND(AVG(delivery_days), 2) AS avg_delivery_days
FROM orders_clean
WHERE delivery_days IS NOT NULL;

-- ── KPI 4: Late delivery rate ───────────────────────────────
SELECT
    ROUND(
        SUM(CASE WHEN is_late_delivery = 'Yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*), 2
    ) AS late_delivery_rate_pct
FROM orders_clean;

-- ── KPI 5: Average review score ────────────────────────────
SELECT ROUND(AVG(review_score), 2) AS avg_review_score
FROM orders_clean
WHERE review_score IS NOT NULL;

-- ── KPI 6: Total unique customers ──────────────────────────
SELECT COUNT(DISTINCT customer_unique_id) AS total_customers
FROM orders_clean;

-- ── KPI 7: Total unique sellers ────────────────────────────
SELECT COUNT(DISTINCT seller_id) AS total_sellers
FROM orders_clean;

-- ── KPI 8: Total unique product categories ─────────────────
SELECT COUNT(DISTINCT product_category) AS total_categories
FROM orders_clean;