/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-524

Title:
Most Popular Tariff Plan by Revenue

Author:
Pavlo Kotenko

Version:
1.0

Description:

For each tariff plan calculate:

- number of users
- total monthly revenue (after discount)
- average revenue per user

Sort the result by total monthly revenue (descending).

Display:

- plan_name
- users_count
- total_monthly_revenue
- average_revenue_per_user

Topics:

- JOIN
- GROUP BY
- SUM
- COUNT
- AVG
- ROUND

Expected Result:

plan_name
users_count
total_monthly_revenue
average_revenue_per_user

==========================================================
*/

WITH total_monthly_revenue AS (
SELECT
s.plan_name,
COUNT (*) AS users_count,
SUM(s.monthly_fee * (1 - (s.discount_percent / 100.0))) AS total_monthly_revenue
FROM subscriptions s
GROUP BY s.plan_name 
),
average_revenue_per_user AS (
SELECT
ROUND(total_monthly_revenue / users_count,2) AS average_revenue_per_user,
plan_name
FROM total_monthly_revenue 
)
SELECT
t.plan_name,
t.users_count,
t.total_monthly_revenue,
a.average_revenue_per_user 
FROM total_monthly_revenue t
JOIN average_revenue_per_user a
ON a.plan_name = t.plan_name 











