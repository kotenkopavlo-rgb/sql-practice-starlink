/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-530

Title:
Revenue Gap Between #1 and #2 Plans

Description:

For each country, determine the two tariff plans
with the highest total monthly revenue.

Calculate the revenue difference between the #1 and #2
plans.

Display:

- country
- top_plan_name
- top_plan_revenue
- second_plan_name
- second_plan_revenue
- revenue_gap

Where:

revenue_gap =
top_plan_revenue - second_plan_revenue

Return exactly ONE row per country.

Monthly revenue must be calculated after discount:

monthly_fee * (1 - discount_percent / 100.0)

Topics:

- JOIN
- GROUP BY
- CTE
- Window Functions
- ROW_NUMBER()
- PARTITION BY
- Conditional Aggregation
- Self JOIN / CTE JOIN

Expected Result:

country
top_plan_name
top_plan_revenue
second_plan_name
second_plan_revenue
revenue_gap

==========================================================
*/

WITH countries_and_tariffs AS(
SELECT
sc.country,
s.plan_name,
SUM(s.monthly_fee * (1 - (s.discount_percent / 100.0))) AS monthly_revenue
FROM starlink_customers sc
JOIN subscriptions s 
ON sc.unique_id = s.customer_id
GROUP BY sc.country, s.plan_name
),
top_two_tariffs_per_country AS (
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY country
ORDER BY monthly_revenue DESC
) AS tariff_rank
FROM countries_and_tariffs 
),
merge_top_two_tariffs AS (
SELECT
country,
MAX(
        CASE
            WHEN tariff_rank = 1 THEN plan_name
        END
    ) AS top_plan_name,
MAX(CASE 
		WHEN tariff_rank = 1 THEN monthly_revenue 
		END
	) AS top_plan_revenue,
MAX(
        CASE
            WHEN tariff_rank = 2 THEN plan_name
        END
    ) AS second_plan_name,
MAX(CASE 
		WHEN tariff_rank = 2 THEN monthly_revenue 
		END
	) AS second_plan_revenue
FROM top_two_tariffs_per_country
WHERE tariff_rank < 3
GROUP BY country
)
SELECT
country,
top_plan_name,
top_plan_revenue,
second_plan_name,
second_plan_revenue,
(top_plan_revenue  - second_plan_revenue ) AS revenue_gap 
FROM merge_top_two_tariffs  





































