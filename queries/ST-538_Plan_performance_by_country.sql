/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-538

Title:
Plan Performance by Country

Author:
Pavlo Kotenko

Version:
1.0

Description:

Analyze the performance of subscription plans across
different countries and identify the most effective plan
in each country based on average revenue per user.

For each combination of country and subscription plan,
calculate:

1. Number of users.
2. Total monthly revenue after discounts.
3. Average monthly revenue per user.

Monthly revenue:

monthly_fee * (1 - discount_percent / 100.0)

Average revenue per user:

total_monthly_revenue / users_count

For each country, select only the subscription plan with
the highest average revenue per user.

If two or more plans have the same average revenue per
user, select the plan with the larger number of users.

Display:

- country
- plan_name
- users_count
- total_monthly_revenue
- average_revenue_per_user

Round calculated revenue values to 2 decimal places.

Sort the final results by average_revenue_per_user in
descending order.

Topics:

- CTE
- JOIN
- GROUP BY
- COUNT()
- SUM()
- ROW_NUMBER()
- PARTITION BY
- ORDER BY
- Multiple sorting criteria
- ROUND()
- Calculated Fields

==========================================================
*/

WITH users_by_countries_and_tariffs AS (
SELECT
sc.country,
s.plan_name,
COUNT(*) AS users_amount,
SUM((s.monthly_fee * (1 - s.discount_percent / 100.0))) AS total_monthly_revenue,
ROUND(AVG((s.monthly_fee * (1 - s.discount_percent / 100.0))),2) AS average_revenue_per_user
FROM starlink_customers sc
JOIN subscriptions s 
ON sc.unique_id = s.customer_id 
GROUP BY sc.country, s.plan_name
),
rank_by_average_revenue AS (
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY country
ORDER BY average_revenue_per_user  DESC, users_amount DESC 
) AS average_revenue_rank
FROM users_by_countries_and_tariffs
)
SELECT *
FROM rank_by_average_revenue 
WHERE average_revenue_rank = 1









