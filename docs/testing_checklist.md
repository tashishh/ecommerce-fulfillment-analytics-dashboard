# Final Testing Checklist

## Data Layer
- [x] Raw CSV files stored in data/raw without modification
- [x] Cleaned dataset saved in data/cleaned
- [x] Feature-engineered columns: delivery_days, is_late_delivery,
      revenue, review_group, order_month
- [x] Row count consistent between raw and cleaned (after filtering
      delivered orders only)

## SQL Layer
- [x] Schema loads without errors
- [x] Total orders match Python: 96,470
- [x] Total revenue matches Python: 15,418,394.83
- [x] Average review score matches Python: 4.05
- [x] Average delivery days matches Python: 12.01
- [x] Late delivery rate matches Python: 6.59%
- [x] All 6 views return correct results

## Flask API Layer
- [x] GET /api/health → {"status": "ok"}
- [x] GET /api/kpis → 5 correct KPI values
- [x] GET /api/monthly-orders → array starting 2016-09
- [x] GET /api/category-revenue → health_beauty first
- [x] GET /api/state-delivery → 27 state rows
- [x] GET /api/payment-summary → 4 payment types
- [x] GET /api/review-delivery → 2 rows (4.18 vs 2.20)

## Frontend Dashboard
- [x] KPI cards show live values (not hardcoded)
- [x] KPI numbers animate on page load
- [x] Monthly orders line chart renders correctly
- [x] Category revenue bar chart renders correctly
- [x] Payment methods doughnut chart renders correctly
- [x] Review vs delivery bar chart renders correctly
- [x] State delivery table shows all 27 rows
- [x] Dark/light theme toggle works
- [x] Dashboard responsive on smaller screens

## Tableau Dashboard
- [x] Monthly orders worksheet matches SQL totals
- [x] Category revenue worksheet matches SQL view
- [x] Delivery by state worksheet shows correct rates
- [x] Review vs delivery comparison is correct
- [x] Payment type breakdown matches API data
- [x] Dashboard filters work correctly

## AWS & GitHub
- [x] Frontend files hosted on S3
- [x] S3 public URL loads HTML and CSS correctly
- [x] Deployment limitations documented honestly
- [x] .env file NOT in GitHub
- [x] All commits are meaningful and descriptive
- [x] Repository is public and accessible