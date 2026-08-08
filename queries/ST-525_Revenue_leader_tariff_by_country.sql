/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-525

Title:
Revenue Leader by Country

Author:
Pavlo Kotenko

Version:
1.0

Description:

For each country determine the subscription plan
that generates the highest total monthly revenue.

Monthly revenue must be calculated after discount:

monthly_fee * (1 - discount_percent / 100.0)

Display:

- country
- plan_name
- total_monthly_revenue

Return exactly ONE plan per country.

Topics:

- JOIN
- GROUP BY
- CTE
- Window Functions
- ROW_NUMBER()
- Calculated Fields

Expected Result:

country
plan_name
total_monthly_revenue

Exactly one plan per country.

==========================================================
*/

WITH monthly_revenue_per_plan_and_country AS (
SELECT
sc.country,
s.plan_name,
SUM((s.monthly_fee * (1 - (s.discount_percent /100.0)))) AS total_monthly_revenue
FROM starlink_customers sc 
JOIN subscriptions s 
ON sc.unique_id = s.customer_id 
GROUP BY sc.country, s.plan_name 
),
ranked_plans_by_country AS (
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY country
ORDER BY total_monthly_revenue DESC
) AS top_tariff
FROM monthly_revenue_per_plan_and_country 
)
SELECT
country,
plan_name,
total_monthly_revenue 
FROM ranked_plans_by_country  
WHERE top_tariff = 1









