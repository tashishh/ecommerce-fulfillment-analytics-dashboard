# Cleaning Log

## Rule 1 — Order Status Filter
- **Action:** Filtered orders table to `order_status = 'delivered'` only
- **Rows removed:** ~2,963 (shipped, canceled, unavailable, invoiced, processing, created, approved)
- **Reason:** `delivery_days` and `is_late_delivery` cannot be calculated for undelivered orders
- **Applied in:** `analysis/02_cleaning_rules.ipynb` Cell 4

## Rule 2 — Null Delivered Customer Date
- **Action:** Dropped rows within delivered orders where `order_delivered_customer_date` is null
- **Rows removed:** Any nulls found within delivered subset
- **Reason:** An order marked delivered with no delivered date is a data quality error
- **Applied in:** `analysis/02_cleaning_rules.ipynb` Cell 5

## Rule 3 — Zero/Negative Price & Freight
- **Action:** Documented counts, kept in dataset with flag for review
- **Rows affected:** Check notebook Cell 6 output for exact count
- **Reason:** Some items may legitimately have zero freight (free shipping promotions)
- **Applied in:** `analysis/02_cleaning_rules.ipynb` Cell 6

## Rule 4 — Duplicate Reviews
- **Action:** Kept latest review per order_id using `review_answer_timestamp`
- **Rows removed:** ~551
- **Reason:** Most recent review reflects final customer sentiment
- **Applied in:** `analysis/02_cleaning_rules.ipynb` Cell 8

## Rule 5 — Missing Product Categories
- **Action:** Filled null `product_category_name` with string `'unknown'`
- **Rows affected:** 610 products
- **Reason:** Price and freight data is still valid for revenue analysis
- **Applied in:** `analysis/02_cleaning_rules.ipynb` Cell 9

## Notes
- Raw files in `data/raw/` were never modified
- All cleaning applied to in-memory DataFrames only
- Cleaned DataFrames will be joined and exported in Day 5-6

## Null Value Decisions

| Column | Null Count | Decision | Reason |
|--------|-----------|----------|--------|
| delivery_days | ~2,965 | Keep as NULL | Orders not delivered — no real value exists |
| estimated_delay_days | ~2,965 | Keep as NULL | Same as above |
| review_score | ~15,698 | Keep as NULL | No review submitted — 'No Review' label in review_group |
| freight_ratio | ~2 | Keep as NULL | price = 0, division undefined |
| review_group | 0 | N/A | Nulls replaced with 'No Review' label ✅ |
| delivery_bucket | 0 | N/A | Nulls replaced with 'Unknown' label ✅ |