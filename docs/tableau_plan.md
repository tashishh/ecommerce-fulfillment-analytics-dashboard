# Tableau Dashboard Plan

## Dataset
File: data/cleaned/tableau_ecommerce_dashboard.csv

## Planned Worksheets
1. Monthly Orders & Revenue — Line chart (order_month vs total_orders / revenue)
2. Category Revenue — Horizontal bar chart sorted by revenue
3. Late Delivery Rate by State — Map or bar chart (customer_state vs is_late_delivery)
4. Review Score vs Delivery Status — Bar chart (is_late_delivery vs avg review_score)
5. Payment Type Distribution — Bar or donut (payment_type vs count)
6. Freight Cost by Category — Bar chart (product_category vs avg_freight_value)

## Dashboard Layout
- Row 1: KPI cards — Total Orders | Total Revenue | Late Delivery Rate | Avg Delivery Days | Avg Review Score
- Row 2: Monthly trend line chart (full width)
- Row 3 Left: Category Revenue bar | Row 3 Right: State Delivery map/bar
- Row 4 Left: Review vs Delivery bar | Row 4 Right: Payment Type chart

## Filters
- order_month (date range)
- customer_state (dropdown)
- product_category (dropdown)
- is_late_delivery (Yes / No toggle)

## Key Story to Tell
Late deliveries cause a 2-point drop in review scores. AL, MA, and SE have the worst delivery rates.
health_beauty and watches_gifts lead revenue. Credit card dominates payments at 75%+.