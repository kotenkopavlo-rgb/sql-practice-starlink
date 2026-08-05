/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-522

Title:
Country Revenue Contribution

Author:
Pavlo Kotenko

Version:
1.0

Description:

For every user display:

- first_name
- last_name
- country
- monthly_revenue
- total_country_revenue
- user_share_percent

Where:

user_share_percent =
(user monthly revenue / total country revenue) * 100

Topics:

- JOIN
- CTE
- Aggregate Functions
- Calculated Fields
- ROUND()

Expected Result:

first_name
last_name
country
monthly_revenue
total_country_revenue
user_share_percent

==========================================================
*/

WITH user_revenue AS (
SELECT
sc.first_name,
sc.last_name,
sc.country,
s.monthly_fee * (1 - (s.discount_percent /100.0)) AS monthly_revenue
FROM starlink_customers sc 
JOIN subscriptions s 
ON sc.unique_id = s.customer_id
),
total_revenue_by_country AS (
SELECT
country,
SUM(monthly_revenue ) AS total_country_revenue
FROM user_revenue
GROUP BY country 
)
SELECT
u.first_name,
u.last_name,
u.country,
u.monthly_revenue,
t.total_country_revenue,
ROUND(((u.monthly_revenue / t.total_country_revenue) * 100.0),2) AS user_share_percent
FROM user_revenue u
JOIN total_revenue_by_country t
ON t.country = u.country 












