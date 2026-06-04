# API to SQL View Mapping

| Flask Endpoint         | SQL View                  | Returns                          |
|------------------------|---------------------------|----------------------------------|
| GET /api/kpis          | kpi_summary               | Single object with 5 KPI values  |
| GET /api/monthly-orders| monthly_order_summary     | Array — one object per month     |
| GET /api/category-revenue | category_revenue_summary | Array — top 15 categories      |
| GET /api/state-delivery| state_delivery_summary    | Array — all 27 states            |
| GET /api/payment-summary | payment_summary          | Array — 4 payment types          |
| GET /api/review-delivery | review_delivery_summary  | Array — 2 rows (late/on-time)    |
| (optional)             | freight_category_summary  | Array — top 15 categories        |