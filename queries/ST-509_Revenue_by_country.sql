/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-509

Title:
Revenue by Country

Author:
Pavlo Kotenko

Description:
Display revenue statistics for each country.

For every country show:

- number of users
- total monthly revenue (with discount)
- average monthly revenue per user

Sort the result by total monthly revenue
in descending order.

Topics:
- INNER JOIN
- GROUP BY
- SUM
- COUNT
- ROUND
- ORDER BY

Expected Result:

country
number_of_users
total_monthly_revenue_with_discount
avg_revenue_per_user

==========================================================
*/

SELECT
sc.country,
COUNT(*) AS number_of_users,
SUM(s.monthly_fee * (1 - s.discount_percent/100.0)) AS total_monthly_revenue_with_discount,
ROUND((SUM(s.monthly_fee * (1 - s.discount_percent/100.0))/COUNT(*)),2) AS average_monthly_revenue_per_user
FROM starlink_customers sc 
JOIN subscriptions s 
ON sc.unique_id = s.customer_id
GROUP BY sc.country 
ORDER BY total_monthly_revenue_with_discount DESC