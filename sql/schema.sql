-- Create the database
CREATE DATABASE IF NOT EXISTS olist_ecommerce;

USE olist_ecommerce;

DROP TABLE IF EXISTS orders_clean;


CREATE TABLE orders_clean (
    -- Identifiers
    order_id                        VARCHAR(50),
    customer_id                     VARCHAR(50),
    order_status                    VARCHAR(20),

    -- Timestamps
    order_purchase_timestamp        DATETIME,
    order_approved_at               DATETIME,
    order_delivered_carrier_date    DATETIME,
    order_delivered_customer_date   DATETIME,
    order_estimated_delivery_date   DATETIME,

    -- Customer info
    customer_unique_id              VARCHAR(50),
    customer_zip_code_prefix        VARCHAR(10),
    customer_city                   VARCHAR(100),
    customer_state                  VARCHAR(5),

    -- Payment (DECIMAL(10,4) to avoid truncation warnings)
    total_payment_value             DECIMAL(10,4),
    payment_installments            INT,
    dominant_payment_type           VARCHAR(20),

    -- Review (NULL allowed — not every order has a review)
    review_score                    TINYINT NULL,
    review_answer_timestamp         DATETIME NULL,

    -- Order item
    order_item_id                   INT,
    product_id                      VARCHAR(50),
    seller_id                       VARCHAR(50),
    shipping_limit_date             DATETIME,

    -- Financials (DECIMAL(10,4) to avoid truncation warnings)
    price                           DECIMAL(10,4),
    freight_value                   DECIMAL(10,4),

    -- Product
    product_category_name           VARCHAR(100),
    product_category                VARCHAR(100),

    -- Engineered delivery features
    delivery_days                   INT,
    estimated_delay_days            INT,
    is_late_delivery                VARCHAR(3),

    -- Time features
    order_month                     VARCHAR(10),
    order_year                      INT,
    order_weekday                   VARCHAR(10),
    order_hour                      INT,

    -- Engineered financial features (DECIMAL(10,4) for precision)
    revenue                         DECIMAL(18,8),
    freight_ratio                   DECIMAL(18,8),

    -- Satisfaction features
    review_group                    VARCHAR(15),
    delivery_bucket                 VARCHAR(10)
);

DESCRIBE orders_clean;