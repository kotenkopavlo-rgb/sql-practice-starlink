/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-529

Title:
Top Revenue Plan in Each Country

Description:

For each country and tariff plan calculate the total
monthly revenue after applying discounts.

Then determine which tariff plan generates the highest
total monthly revenue within each country.

Display:

- country
- plan_name
- total_monthly_revenue
- country_plan_rank

Return exactly ONE plan per country.

If two plans have the same revenue, still return only
one plan.

Monthly revenue:

monthly_fee * (1 - discount_percent / 100.0)

Topics:

- JOIN
- GROUP BY
- CTE
- Window Functions
- ROW_NUMBER()
- PARTITION BY
- ORDER BY

Expected Result:

country
plan_name
total_monthly_revenue
country_plan_rank

==========================================================
*/

WITH monthly_revenue_by_plan AS (
SELECT
sc.country,
s.plan_name,
SUM(s.monthly_fee * (1 - (s.discount_percent / 100.0))) AS total_monthly_revenue
FROM starlink_customers sc
JOIN subscriptions s 
ON sc.unique_id = s.customer_id
GROUP BY sc.country, s.plan_name
),
top_tariff_by_country AS (
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY country  
ORDER BY total_monthly_revenue DESC 
) AS plan_rank
FROM monthly_revenue_by_plan 
)
SELECT *
FROM top_tariff_by_country  
WHERE plan_rank < 2




















