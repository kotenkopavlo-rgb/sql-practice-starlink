/*
Project: SQL Practice – Starlink Analytics
Task: ST-568
Title: Country Customer Value Analysis
Author: Pavlo Kotenko
Version: 1.0

Description:
Analyze customer revenue and usage by country.

Display:
- Country
- Number of customers
- Total revenue after discount
- Average revenue per customer
- Total data usage
- Average data usage per customer
- Revenue per GB

Revenue after discount:
monthly_fee * (1 - discount_percent / 100.0)

Total data usage:
gb_downloaded + gb_uploaded

Revenue per GB:
total revenue after discount / total data usage

Requirements:
- Join starlink_customers with subscriptions.
- Group customers by country.
- Count customers.
- Calculate total revenue after discount.
- Calculate average revenue per customer.
- Calculate total and average data usage.
- Calculate revenue per GB.
- Avoid division by zero.
- Round calculated metrics to two decimals.
- Sort countries by total revenue after discount descending.

Topics:
JOIN
GROUP BY
COUNT
SUM
AVG
CTE
Arithmetic calculations
NULLIF
ROUND
ORDER BY
*/

WITH statistic_by_customers AS (
SELECT
sc.unique_id,
sc.country,
s.monthly_fee * (1 - (s.discount_percent / 100.0)) AS revenue_after_discount,
(sc.gb_downloaded + sc.gb_uploaded) AS total_usage
FROM starlink_customers sc
JOIN subscriptions s 
ON sc.unique_id = s.customer_id
),
country_statistics AS (
SELECT
country,
COUNT(*) AS customers_count,
SUM(revenue_after_discount) AS total_revenue,
AVG(revenue_after_discount) AS avg_revenue_per_customer,
SUM(total_usage) AS total_usage,
AVG(total_usage) AS avg_usage_per_customer
FROM statistic_by_customers
GROUP BY country
),
country_metrics AS (
SELECT *,
ROUND(total_revenue / NULLIF(total_usage, 0), 2) AS revenue_per_gb
FROM country_statistics
)
SELECT *
FROM country_metrics
ORDER BY total_revenue DESC







