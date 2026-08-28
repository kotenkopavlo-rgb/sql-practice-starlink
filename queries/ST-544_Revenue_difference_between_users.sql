/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-544

Title:
Revenue Difference Between Users

Author:
Pavlo Kotenko

Version:
1.0

Description:

Analyze individual customer revenue and compare each
user's monthly revenue with the revenue of the next user
within the same country.

For each user, calculate:

1. Monthly revenue after applying the subscription
   discount.
2. Revenue of the next user within the same country.
3. Difference between the current user's revenue and the
   next user's revenue.
4. Percentage difference between the current user's
   revenue and the next user's revenue.

Monthly revenue:

monthly_fee * (1 - discount_percent / 100.0)

Next user revenue:

Use the LEAD() window function.

Users must be partitioned by country and ordered by
monthly_revenue in descending order.

LEAD() should return the monthly revenue of the next user
in the ordered result.

For the last user in each country, next_user_revenue
will be NULL.

Revenue difference:

monthly_revenue - next_user_revenue

Revenue gap percentage:

(revenue_difference / next_user_revenue) * 100

For the last user in each country, both
next_user_revenue and revenue_gap_percentage will be NULL.

Display:

- first_name
- last_name
- country
- plan_name
- monthly_revenue
- next_user_revenue
- revenue_difference
- revenue_gap_percentage

Round monetary values and percentage values to 2 decimal
places.

Sort the final results by:

1. country ASC
2. monthly_revenue DESC

Topics:

- CTE
- JOIN
- LEAD()
- Window Functions
- PARTITION BY
- ORDER BY
- NULL
- Calculated Fields
- Percentage Calculations
- ROUND()

==========================================================
*/

WITH customer_statistic AS (
SELECT 
sc.first_name,
sc.last_name,
sc.country,
s.plan_name,
(s.monthly_fee * (1 - s.discount_percent / 100.0)) AS monthly_revenue
FROM starlink_customers sc
JOIN subscriptions s 
ON sc.unique_id = s.customer_id 
),
comparison_with_next_customer AS (
SELECT *,
LEAD(monthly_revenue) OVER(
PARTITION BY country 
ORDER BY monthly_revenue DESC
) AS next_user_revenue
FROM customer_statistic 
)
SELECT
first_name,
last_name,
country,
plan_name,
monthly_revenue,
next_user_revenue,
(monthly_revenue - next_user_revenue) AS revenue_difference,
ROUND((((monthly_revenue - next_user_revenue)/next_user_revenue) * 100.0),2) AS revenue_gap_percentage
FROM comparison_with_next_customer
ORDER BY country ASC, monthly_revenue DESC




















