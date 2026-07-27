/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-515

Title:
Country Revenue Share

Author:
Pavlo Kotenko

Description:
Display the revenue contribution of each country.

For every country show:

- total monthly revenue (with discount)
- percentage of global revenue

Sort the result by total revenue
in descending order.

Topics:
- CTE
- Aggregate Functions
- SUM
- CROSS JOIN
- ROUND

Expected Result:

country
total_revenue
percentage_of_global_revenue

==========================================================
*/

WITH country_revenue AS (
SELECT
sc.country,
SUM(s.monthly_fee * (1 - (s.discount_percent/100.0))) AS total_revenue_by_country
FROM starlink_customers sc
JOIN subscriptions s 
ON sc.unique_id = s.customer_id
GROUP BY sc.country 
),
total_revenue AS (
SELECT
SUM(total_revenue_by_country) AS total_revenue_by_all_countries
FROM country_revenue
)
SELECT 
country,
total_revenue_by_country AS total_revenue,
ROUND(((total_revenue_by_country * 1.0 /total_revenue_by_all_countries)) * 100,2) AS percentage_of_global_revenue
FROM country_revenue
CROSS JOIN total_revenue 
