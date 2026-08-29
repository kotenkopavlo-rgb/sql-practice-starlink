/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-545

Title:
User Revenue Neighbors

Author:
Pavlo Kotenko

Version:
1.0

Description:

Analyze each customer's monthly revenue in relation to
the users immediately before and after them within the
same country.

Users must be ordered by monthly revenue in descending
order within each country.

For each user, calculate:

1. Monthly revenue.
2. Revenue of the previous user in the country.
3. Revenue of the next user in the country.
4. Difference between the current user's revenue and the
   previous user's revenue.
5. Difference between the current user's revenue and the
   next user's revenue.
6. User position within the country.

Monthly revenue:

monthly_fee * (1 - discount_percent / 100.0)

Previous user revenue:

Use the LAG() window function.

Next user revenue:

Use the LEAD() window function.

Both window functions must use:

PARTITION BY country
ORDER BY monthly_revenue DESC

Difference from previous user:

monthly_revenue - previous_user_revenue

Difference to next user:

monthly_revenue - next_user_revenue

User position:

Top:
previous_user_revenue IS NULL

Bottom:
next_user_revenue IS NULL

Middle:
all other users

Use CASE WHEN to determine the user's position.

For the first user in each country,
previous_user_revenue will be NULL.

For the last user in each country,
next_user_revenue will be NULL.

Do not exclude users with NULL values.

Display:

- first_name
- last_name
- country
- plan_name
- monthly_revenue
- previous_user_revenue
- next_user_revenue
- difference_from_previous
- difference_to_next
- user_position

Round monetary values and calculated differences to
2 decimal places.

Sort the final results by:

1. country ASC
2. monthly_revenue DESC

Topics:

- CTE
- JOIN
- LAG()
- LEAD()
- Window Functions
- PARTITION BY
- ORDER BY
- CASE WHEN
- NULL
- Calculated Fields
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
comparison_customers AS (
SELECT *,
LAG(monthly_revenue ) OVER (
PARTITION BY country
ORDER BY monthly_revenue DESC
) previous_user_revenue,
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
ROUND(previous_user_revenue,2) AS previous_user_revenue,
ROUND(next_user_revenue,2) AS previous_user_revenue,
ROUND((monthly_revenue - previous_user_revenue),2) AS difference_from_previous,
ROUND((monthly_revenue - next_user_revenue),2) AS difference_to_next,
CASE
	WHEN previous_user_revenue is NULL THEN 'Top'
	WHEN next_user_revenue is NULL THEN 'Bottom'
	ELSE 'Middle'
END AS 'user_position'
FROM comparison_customers  
ORDER BY country ASC, monthly_revenue DESC























