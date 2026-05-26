# Data Dictionary

## olist_orders_dataset.csv
| Column | Type | Description |
|--------|------|-------------|
| order_id | string | Unique identifier for each order |
| customer_id | string | Links to customers table |
| order_status | string | Current status: delivered, shipped, cancelled, etc. |
| order_purchase_timestamp | datetime | When the customer placed the order |
| order_approved_at | datetime | When payment was approved |
| order_delivered_carrier_date | datetime | When the seller handed order to carrier |
| order_delivered_customer_date | datetime | When the customer actually received the order |
| order_estimated_delivery_date | datetime | Estimated delivery date shown to customer at purchase |

## olist_order_items_dataset.csv
| Column | Type | Description |
|--------|------|-------------|
| order_id | string | Links to orders table |
| order_item_id | integer | Item sequence number within an order (1, 2, 3...) |
| product_id | string | Links to products table |
| seller_id | string | Links to sellers table |
| shipping_limit_date | datetime | Deadline for seller to ship the item |
| price | decimal | Item price paid by customer (excludes freight) |
| freight_value | decimal | Shipping cost for this item |

## olist_order_payments_dataset.csv
| Column | Type | Description |
|--------|------|-------------|
| order_id | string | Links to orders table |
| payment_sequential | integer | Payment sequence (some orders split across payment types) |
| payment_type | string | credit_card, boleto, voucher, debit_card |
| payment_installments | integer | Number of installments chosen by customer |
| payment_value | decimal | Value of this payment row |

## olist_order_reviews_dataset.csv
| Column | Type | Description |
|--------|------|-------------|
| review_id | string | Unique review identifier |
| order_id | string | Links to orders table |
| review_score | integer | Customer satisfaction score: 1 (worst) to 5 (best) |
| review_creation_date | datetime | When the review form was sent to customer |
| review_answer_timestamp | datetime | When the customer submitted their review |

## olist_customers_dataset.csv
| Column | Type | Description |
|--------|------|-------------|
| customer_id | string | Links to orders table |
| customer_unique_id | string | True unique customer (one person may have multiple customer_ids) |
| customer_city | string | Customer's city |
| customer_state | string | Brazilian state abbreviation (e.g. SP, RJ, MG) |
| customer_zip_code_prefix | string | Zip code prefix |

## olist_products_dataset.csv
| Column | Type | Description |
|--------|------|-------------|
| product_id | string | Links to items table |
| product_category_name | string | Category name in Portuguese |
| product_name_lenght | integer | Character count of product name |
| product_description_lenght | integer | Character count of product description |
| product_photos_qty | integer | Number of product photos |
| product_weight_g | integer | Product weight in grams |
| product_length_cm | integer | Product length in cm |
| product_height_cm | integer | Product height in cm |
| product_width_cm | integer | Product width in cm |

## product_category_name_translation.csv
| Column | Type | Description |
|--------|------|-------------|
| product_category_name | string | Category name in Portuguese (join key) |
| product_category_name_english | string | English translation used in all dashboards |

---

## Engineered Features (added in Day 6)
| Feature | Formula | Description |
|---------|---------|-------------|
| delivery_days | delivered_date - purchase_timestamp | Days customer waited for delivery |
| estimated_delay_days | delivered_date - estimated_delivery_date | Positive = late, Negative = early |
| is_late_delivery | estimated_delay_days > 0 → Yes, else No | Late delivery flag |
| revenue | price + freight_value | Total order item value including shipping |
| freight_ratio | freight_value / price | Shipping cost relative to item price |
| order_month | month from purchase_timestamp | Used for monthly trend charts |
| order_weekday | weekday from purchase_timestamp | Used for weekly pattern analysis |
| review_group | 1-2 → Low, 3 → Medium, 4-5 → High | Satisfaction group label |
| delivery_bucket | Based on delivery_days thresholds | Fast / Normal / Slow grouping |