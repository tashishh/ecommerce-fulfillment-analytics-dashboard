# Join Plan

## Final Dataset Type
Order-item level — one row per order item.
Payment data aggregated to order level before joining.
Review data already deduplicated to one row per order (Day 4).

## Join Sequence

### Step 1 — Aggregate payments to order level
- Table: olist_order_payments_dataset.csv
- Group by: order_id
- Aggregations:
  - total_payment_value = SUM(payment_value)
  - payment_installments = MAX(payment_installments)
  - dominant_payment_type = most frequent payment_type per order
- Join type: LEFT JOIN to orders
- Risk: Multiple payment rows per order — must aggregate FIRST

### Step 2 — Deduplicate reviews (already done in Day 4)
- Keep latest review per order_id
- Join type: LEFT JOIN to orders
- Risk: Small number of duplicate reviews — handled

### Step 3 — Join orders (delivered, cleaned) + customers
- Key: customer_id
- Join type: LEFT JOIN
- Expected: 1-to-1 (each order has one customer)

### Step 4 — Join orders + payments (aggregated)
- Key: order_id
- Join type: LEFT JOIN
- Expected: 1-to-1 after aggregation

### Step 5 — Join orders + reviews (deduplicated)
- Key: order_id
- Join type: LEFT JOIN
- Expected: 1-to-1 after deduplication

### Step 6 — Join items to the above merged table
- Key: order_id
- Join type: LEFT JOIN
- Expected: row count INCREASES here (order-item level)
- This is the LAST join to avoid multiplying item rows

### Step 7 — Join items + products
- Key: product_id
- Join type: LEFT JOIN
- Expected: 1-to-1

### Step 8 — Join products + translation
- Key: product_category_name
- Join type: LEFT JOIN
- Expected: 1-to-1 (some categories may not match — will become NaN)

## Row Count Expectations
- After Step 5 (order level): ~96,470 rows
- After Step 6 (order-item level): ~111,XXX rows (more than orders, fewer than raw items)
- Final check: unique order_id count should still be ~96,470