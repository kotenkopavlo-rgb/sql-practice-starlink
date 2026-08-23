/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-539

Title:
Customer Revenue Ranking

Author:
Pavlo Kotenko

Version:
1.0

Description:

Analyze customer monthly revenue and rank users by revenue
within their respective countries.

For each user, calculate:

1. Monthly revenue after applying the subscription discount.
2. Average monthly revenue per user in their country.
3. Revenue rank within the country.
4. Difference between the user's revenue and the country
   average revenue.

Monthly revenue:

monthly_fee * (1 - discount_percent / 100.0)

Country average revenue:

AVG(monthly_revenue) calculated for all users within
the same country.

Revenue difference:

monthly_revenue - country_average_revenue

Revenue ranking:

Rank users within each country by monthly revenue in
descending order.

Users with the same monthly revenue must receive the
same rank.

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
- revenue_rank
- revenue_vs_average

Round calculated revenue values to 2 decimal places.

Sort the final results by:

1. country ASC
2. revenue_rank ASC

Topics:

- CTE
- JOIN
- GROUP BY
- AVG()
- RANK()
- PARTITION BY
- ORDER BY
- Window Functions
- Calculated Fields
- ROUND()
- WHERE

==========================================================
*/

WITH user_by_country AS (
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
average_revenue_by_country AS (
SELECT
sc.country,
ROUND(AVG((s.monthly_fee * (1 - s.discount_percent / 100.0))),2) AS country_average_revenue
FROM starlink_customers sc 
JOIN subscriptions s 
ON sc.unique_id = s.customer_id
GROUP BY sc.country 
),
statistic_by_each_user AS (
SELECT *,
country_average_revenue
FROM user_by_country u
JOIN average_revenue_by_country a
ON a.country = u.country 
)
SELECT
first_name,
last_name,
country,
plan_name,
monthly_revenue,
country_average_revenue,
RANK() OVER (
PARTITION BY country
ORDER BY monthly_revenue DESC
) AS revenue_rank,
(monthly_revenue - country_average_revenue) AS revenue_as_average
FROM statistic_by_each_user 
WHERE monthly_revenue > country_average_revenue 













