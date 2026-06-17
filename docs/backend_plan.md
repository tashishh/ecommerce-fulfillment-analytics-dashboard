# Backend Plan

## Technology
- Python 3.x + Flask
- mysql-connector-python for database
- flask-cors for frontend access
- python-dotenv for credentials

## Endpoints

| Endpoint              | View Used                 | Returns                        |
|-----------------------|---------------------------|--------------------------------|
| GET /api/health       | none                      | Server status message          |
| GET /api/kpis         | kpi_summary               | Single object — 5 KPI values   |
| GET /api/monthly-orders | monthly_order_summary   | Array — one object per month   |
| GET /api/category-revenue | category_revenue_summary | Array — top 15 categories |
| GET /api/state-delivery | state_delivery_summary  | Array — all 27 states          |
| GET /api/payment-summary | payment_summary        | Array — 4 payment types        |
| GET /api/review-delivery | review_delivery_summary | Array — 2 rows (late/on-time) |

## JSON Response Format

### /api/kpis — single object
```json
{
  "total_orders": 96470,
  "total_revenue": 15418394.83,
  "avg_delivery_days": 12.01,
  "late_delivery_rate": 6.59,
  "avg_review_score": 4.05
}
```

### /api/monthly-orders — array
```json
[
  { "order_month": "2016-09", "total_orders": 1, "total_revenue": 143.46 },
  { "order_month": "2016-10", "total_orders": 265, "total_revenue": 46490.66 }
]
```

## Security Notes
- DB credentials stored in .env (never committed to GitHub)
- CORS enabled for local frontend development only
- Error handling on all routes returns readable JSON