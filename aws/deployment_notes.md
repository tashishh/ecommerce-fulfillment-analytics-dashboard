# AWS Deployment Notes

## What Was Deployed
- Frontend static files (index.html, style.css, app.js) hosted on AWS S3
- Static website hosting enabled on S3 bucket

## S3 Bucket Details
- Bucket name: ecommerce-analytics-ashish
- Region: us-west-1
- Endpoint: http://ecommerce-analytics-dashboard.s3-website-us-west-1.amazonaws.com/
- Hosting type: Static website hosting

## What Is Still Local
- Flask backend (app.py) runs on localhost:5000
- MySQL database runs on localhost:3306
- API calls from S3-hosted frontend fail because the browser
  cannot reach a local backend from a public URL

## Known Limitation
The frontend loads correctly on S3 but KPI cards and charts
show blank/placeholder values because the Flask API is not
publicly hosted. This is a CORS + network limitation, not a
code error.

## Future Improvement Plan
To make the full stack publicly accessible:
1. Deploy Flask backend to AWS EC2 or Elastic Beanstalk
2. Move MySQL to AWS RDS
3. Update API_URL in app.js from localhost:5000 to the EC2 public IP
4. Re-upload app.js to S3

## Steps Completed
- [x] S3 bucket created with public access enabled
- [x] Static website hosting configured
- [x] Bucket policy set for public read
- [x] Frontend files uploaded (index.html, style.css, app.js)
- [x] Public URL tested — HTML/CSS loads correctly
- [x] Limitations documented honestly