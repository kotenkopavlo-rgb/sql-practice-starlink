/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-520

Title:
Most Popular Subscription Plan per Country

Author:
Pavlo Kotenko

Version:
1.0

Description:

For each country display the subscription plan
that has the largest number of users.

Display:

- country
- plan_name
- users_count

Topics:

- INNER JOIN
- GROUP BY
- CTE
- ROW_NUMBER()

Expected Result:

country
plan_name
users_count

Exactly one plan per country.

==========================================================
*/

WITH group_by_plan_name AS (
SELECT
sc.country,
s.plan_name,
COUNT(*) AS users_count
FROM starlink_customers sc
JOIN subscriptions s 
ON sc.unique_id = s.customer_id
GROUP BY sc.country, s.plan_name 
),
top_tariff_for_each_country AS(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY country
ORDER BY users_count  DESC
) AS popularity_rank
FROM group_by_plan_name 
)
SELECT *
FROM top_tariff_for_each_country  
WHERE popularity_rank = 1
ORDER BY country 


