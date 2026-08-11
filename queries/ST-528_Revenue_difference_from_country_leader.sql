/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-528

Title:
Revenue Difference from Country Leader

Description:

Calculate the total monthly revenue for each country
after applying discounts.

Then determine the revenue of the highest-earning country
and show how much revenue each country generates compared
with that leader.

Display:

- country
- total_monthly_revenue
- highest_country_revenue
- revenue_difference

Where:

revenue_difference =
highest_country_revenue - total_monthly_revenue

The highest-earning country should therefore have
revenue_difference = 0.

Topics:

- JOIN
- GROUP BY
- CTE
- MAX()
- CROSS JOIN
- Calculated Fields

Expected Result:

country
total_monthly_revenue
highest_country_revenue
revenue_difference

==========================================================
*/

WITH monthly_revenue_by_country AS (
SELECT
sc.country,
SUM(s.monthly_fee * (1 - s.discount_percent/100.0)) AS total_monthly_revenue 
FROM starlink_customers sc
JOIN subscriptions s
ON sc.unique_id = s.customer_id
GROUP BY sc.country
),
top_country_by_revenue AS (
SELECT
MAX(total_monthly_revenue ) AS highest_country_revenue
FROM monthly_revenue_by_country
)
SELECT
country,
total_monthly_revenue,
t.highest_country_revenue,
(highest_country_revenue - m.total_monthly_revenue) AS revenue_difference
FROM monthly_revenue_by_country m
CROSS JOIN top_country_by_revenue t
ORDER BY m.total_monthly_revenue DESC








