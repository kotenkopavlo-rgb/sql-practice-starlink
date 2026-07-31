/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-518

Title:
Top Revenue User per Country

Author:
Pavlo Kotenko

Version:
1.0

Description:

For each country display the customer
who brings the highest monthly revenue.

Monthly revenue should be calculated as:

monthly_fee * (1 - discount_percent / 100.0)

Display:

- first_name
- last_name
- country
- plan_name
- monthly_revenue

Topics:

- INNER JOIN
- CTE
- ROW_NUMBER()
- Calculated Columns

Expected Result:

first_name
last_name
country
plan_name
monthly_revenue

Exactly one customer per country.

==========================================================
*/

WITH top_users_by_revenue_in_each_country AS(
SELECT
sc.first_name,
sc.last_name,
sc.country,
s.plan_name,
(s.monthly_fee * ((1 - s.discount_percent/100.0))) AS monthly_revenue_per_user
FROM starlink_customers sc
JOIN subscriptions s 
ON sc.unique_id = s.customer_id
),
top_one_user_by_revenue_in_each_country AS(
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY country 
ORDER BY monthly_revenue_per_user DESC
) AS rating
FROM top_users_by_revenue_in_each_country
)
SELECT *
FROM top_one_user_by_revenue_in_each_country
WHERE rating = 1















