/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-543

Title:
Comparing User Revenue

Author:
Pavlo Kotenko

Version:
1.0

Description:

Analyze individual customer revenue and compare each
user's monthly revenue with the revenue of the previous
user within the same country.

For each user, calculate:

1. Monthly revenue after applying the subscription
   discount.
2. Revenue of the previous user within the same country.
3. Difference between the current user's revenue and the
   previous user's revenue.

Monthly revenue:

monthly_fee * (1 - discount_percent / 100.0)

Previous user revenue:

Use the LAG() window function.

Users must be partitioned by country and ordered by
monthly_revenue in descending order.

LAG() should return the monthly revenue of the previous
user in the ordered result.

For the first user in each country, previous_user_revenue
will be NULL.

Revenue difference:

monthly_revenue - previous_user_revenue

Do not exclude users with NULL previous_user_revenue.

Display:

- first_name
- last_name
- country
- plan_name
- monthly_revenue
- previous_user_revenue
- revenue_difference

Round monetary values to 2 decimal places.

Sort the final results by:

1. country ASC
2. monthly_revenue DESC

Topics:

- CTE
- JOIN
- LAG()
- Window Functions
- PARTITION BY
- ORDER BY
- NULL
- Calculated Fields
- ROUND()

==========================================================
*/

WITH user_statistic AS (
SELECT
sc.first_name,
sc.last_name,
sc.country,
s.plan_name,
(s.monthly_fee * 1 - s.discount_percent / 100.0) AS monthly_revenue
FROM starlink_customers sc
JOIN subscriptions s 
ON sc.unique_id = s.customer_id
),
comparison_with_previous_user AS (
SELECT *,
LAG(monthly_revenue ) OVER (
PARTITION BY country
ORDER BY monthly_revenue DESC
) previous_user_revenue
FROM user_statistic 
)
SELECT
first_name,
last_name,
country,
plan_name,
ROUND(monthly_revenue, 2) AS monthly_revenue,
ROUND(previous_user_revenue, 2) AS previous_user_revenue,
ROUND((monthly_revenue - previous_user_revenue), 2) AS revenue_difference
FROM comparison_with_previous_user
ORDER BY country ASC, monthly_revenue DESC









