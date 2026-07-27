/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-504

Title:
Countries Above Average Revenue

Author:
Pavlo Kotenko

Description:
Calculate the total monthly revenue for each country.

Then calculate the average monthly revenue
across all countries.

Display only those countries whose total
monthly revenue is higher than the average
country revenue.

Topics:
- CTE
- Aggregate Functions
- AVG
- SUM
- WHERE
- CROSS JOIN

Expected Result:

country
total_revenue

==========================================================
*/

WITH total_monthly_revenue_by_countries AS (
SELECT
sc.country,
SUM(s.monthly_fee * (1 - s.discount_percent / 100.0)) AS total_revenue_by_country
FROM starlink_customers sc
JOIN subscriptions s 
ON sc.unique_id = s.customer_id
GROUP BY country 
),
avg_revenue_by_all_countries AS(
SELECT
(SUM(total_revenue_by_country )/COUNT(country )) AS avg_revenue_by_all_counties
FROM total_monthly_revenue_by_countries 
)
SELECT 
country,
total_revenue_by_country 
FROM total_monthly_revenue_by_countries
CROSS JOIN avg_revenue_by_all_countries
WHERE total_revenue_by_country > avg_revenue_by_all_counties 

