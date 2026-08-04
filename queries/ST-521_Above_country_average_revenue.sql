/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-521

Title:
Users Above Country Average Revenue

Author:
Pavlo Kotenko

Version:
1.0

Description:

Display all users whose individual monthly revenue
is HIGHER than the average monthly revenue
of users from the same country.

Monthly revenue:

monthly_fee * (1 - discount_percent / 100.0)

Display:

- first_name
- last_name
- country
- plan_name
- monthly_revenue
- country_average_revenue

Topics:

- JOIN
- CTE
- Aggregate Functions
- Correlated Logic

Expected Result:

first_name
last_name
country
plan_name
monthly_revenue
country_average_revenue

==========================================================
*/

WITH monthly_revenue_by_users AS (
SELECT
sc.first_name,
sc.last_name,
sc.country,
s.plan_name,
(s.monthly_fee * (1 - s.discount_percent/100.0)) AS monthly_revenue_with_discount 
FROM starlink_customers sc
JOIN subscriptions s 
ON sc.unique_id = s.customer_id
),
average_revenue_per_country AS (
SELECT
country, 
ROUND((AVG(monthly_revenue_with_discount)),2) AS country_average_revenue
FROM monthly_revenue_by_users
GROUP BY country 
),
revenue_comparison AS (
SELECT *
FROM monthly_revenue_by_users m
JOIN average_revenue_per_country a
ON m.country = a.country 
)
SELECT
first_name,
last_name,
country,
plan_name,
monthly_revenue_with_discount,
country_average_revenue
FROM revenue_comparison
WHERE monthly_revenue_with_discount > country_average_revenue 

