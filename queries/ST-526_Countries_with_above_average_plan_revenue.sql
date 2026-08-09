/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-526

Title:
Countries with Above-Average Plan Revenue

Author:
Pavlo Kotenko

Version:
1.0

Description:

For each country and tariff plan calculate the total
monthly revenue after discount.

Then display only those country/plan combinations
whose revenue is ABOVE the average revenue of all
country/plan combinations.

Monthly revenue:

monthly_fee * (1 - discount_percent / 100.0)

Display:

- country
- plan_name
- total_monthly_revenue
- average_plan_country_revenue

Return only combinations where:

total_monthly_revenue > average_plan_country_revenue

Topics:

- JOIN
- GROUP BY
- CTE
- Aggregate Functions
- CROSS JOIN
- ROUND

Expected Result:

country
plan_name
total_monthly_revenue
average_plan_country_revenue

==========================================================
*/

WITH monthly_revenue_by_tariff_and_country AS (
SELECT
sc.country,
s.plan_name,
SUM(s.monthly_fee * (1 - (s.discount_percent /100.0))) AS total_monthly_revenue
FROM starlink_customers sc
JOIN subscriptions s 
ON sc.unique_id = s.customer_id
GROUP BY sc.country, s.plan_name
),
average_monthly_revenue_by_all_countries AS (
SELECT
AVG(total_monthly_revenue) AS average_plan_country_revenue
FROM monthly_revenue_by_tariff_and_country 
)
SELECT
m.country,
m.plan_name,
m.total_monthly_revenue,
a.average_plan_country_revenue 
FROM average_monthly_revenue_by_all_countries a
CROSS JOIN monthly_revenue_by_tariff_and_country m
-- WHERE m.total_monthly_revenue > a.average_plan_country_revenue 















