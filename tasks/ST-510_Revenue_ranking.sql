/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-510

Title:
Revenue Market Category

Author:
Pavlo Kotenko

Version:
1.0

Description:
For each country display:

- total users
- total monthly revenue
- average downloaded traffic
- market category
- revenue ranking

Topics:
- CASE
- CTE
- RANK()
- Window Functions

Expected Result:

country
total_users
total_month_revenue
avg_gb_downloaded
market_category
revenue_rank

==========================================================
*/

WITH country_stats AS(
SELECT
sc.country,
COUNT(sc.unique_id ) AS total_users,
SUM(s.monthly_fee * (1 - s.discount_percent /100.0) ) AS total_month_revenue,
ROUND(AVG(sc.gb_downloaded ),2) AS avg_gb_downloaded,
 CASE
	WHEN SUM(s.monthly_fee * (1 - s.discount_percent /100.0) ) < 30001 THEN 'Small'
	WHEN SUM(s.monthly_fee * (1 - s.discount_percent /100.0) ) < 60001 THEN 'Medium'
	ELSE 'Large'
END AS market_category
FROM starlink_customers sc
JOIN subscriptions s 
ON sc.unique_id = s.customer_id
GROUP BY sc.country
)
SELECT
country,
total_users,
avg_gb_downloaded,
total_month_revenue,
market_category, 
RANK() OVER (
ORDER BY total_month_revenue DESC
) AS revenue_rank
FROM country_stats 
