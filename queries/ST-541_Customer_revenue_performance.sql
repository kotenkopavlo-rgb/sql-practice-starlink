/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-541

Title:
Customer Revenue Performance

Author:
Pavlo Kotenko

Version:
1.0

Description:

Analyze individual customer revenue and compare each
customer's monthly revenue with the average revenue of
their country.

For each user, calculate:

1. Monthly revenue after applying the subscription discount.
2. Average monthly revenue per user in their country.
3. Difference between the user's revenue and the country
   average revenue.
4. Customer performance category.

Monthly revenue:

monthly_fee * (1 - discount_percent / 100.0)

Country average revenue:

AVG(monthly_revenue) calculated for all users within
the same country.

Revenue difference:

monthly_revenue - country_average_revenue

Performance categories:

High Performer:
monthly_revenue >= country_average_revenue * 1.20

Above Average:
monthly_revenue > country_average_revenue
AND
monthly_revenue < country_average_revenue * 1.20

Below Average:
monthly_revenue <= country_average_revenue

Use CASE WHEN to assign the appropriate performance
category.

Filter:

Return only users whose monthly revenue is higher than
the average revenue of their country.

Display:

- first_name
- last_name
- country
- plan_name
- monthly_revenue
- country_average_revenue
- revenue_difference
- performance_category

Round monetary values and calculated differences to
2 decimal places.

Sort the final results by:

1. country ASC
2. monthly_revenue DESC

Topics:

- CTE
- JOIN
- AVG()
- CASE WHEN
- Calculated Fields
- Conditional Logic
- Percentage Comparison
- WHERE
- ORDER BY
- ROUND()

==========================================================
*/

WITH statistic_by_user AS (
SELECT 
sc.first_name,
sc.last_name,
sc.country,
s.plan_name,
ROUND(s.monthly_fee * (1 - s.discount_percent / 100.0),2) AS monthly_revenue
FROM starlink_customers sc
JOIN subscriptions s 
ON sc.unique_id = s.customer_id 
),
average_revenue_by_country AS (
SELECT
sc.country,
ROUND(AVG(s.monthly_fee * (1 - s.discount_percent / 100.0)),2) AS country_average_revenue
FROM starlink_customers sc
JOIN subscriptions s 
ON sc.unique_id = s.customer_id
GROUP BY sc.country 
),
all_statistic AS (
SELECT
s.first_name,
s.last_name,
s.country,
s.plan_name,
s.monthly_revenue,
a.country_average_revenue,
(s.monthly_revenue - a.country_average_revenue)  AS revenue_difference,
CASE
	WHEN s.monthly_revenue >= a.country_average_revenue * 1.20 THEN 'high_performer'
	WHEN s.monthly_revenue >= a.country_average_revenue THEN 'above_average'
	ELSE 'below_average'
END AS 'performance_category'
FROM statistic_by_user s 
JOIN average_revenue_by_country a
ON a.country = s.country 
WHERE s.monthly_revenue > a.country_average_revenue
)
SELECT *
FROM all_statistic  
ORDER BY country ASC, monthly_revenue DESC



























