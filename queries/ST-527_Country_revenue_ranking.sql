/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-527

Title:
Country Revenue Ranking

Author:
Pavlo Kotenko

Version:
1.0

Description:

Calculate the total monthly revenue for each country
after applying discounts.

Then rank all countries from highest to lowest
by total monthly revenue.

Display:

- country
- total_monthly_revenue
- country_rank

The country with the highest revenue should have rank 1.

If two countries have exactly the same revenue,
they should receive the same rank.

Topics:

- JOIN
- GROUP BY
- SUM
- CTE
- Window Functions
- RANK()

Expected Result:

country
total_monthly_revenue
country_rank

==========================================================
*/

WITH monthly_revenue_by_country AS (
SELECT
sc.country,
SUM((s.monthly_fee * (1 - s.discount_percent/100.0))) AS total_monthly_revenue
FROM starlink_customers sc
JOIN subscriptions s 
ON sc.unique_id = s.customer_id
GROUP BY sc.country 
),
rank_by_countries AS (
SELECT *,
RANK() OVER (
ORDER BY total_monthly_revenue DESC  
) AS country_rank
FROM monthly_revenue_by_country 
)
SELECT
country,
total_monthly_revenue,
country_rank 
FROM rank_by_countries



















