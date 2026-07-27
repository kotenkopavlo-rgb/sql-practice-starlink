/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-501

Title:
Revenue by Tariff Plan

Author:
Pavlo Kotenko

Description:
Display the number of users and total monthly revenue
for each tariff plan.

Topics:
- GROUP BY
- SUM
- COUNT
- Aggregate Functions

Expected Result:

plan_name
amount_of_users
total_monthly_revenue

==========================================================
*/

SELECT
plan_name,
COUNT(*) AS amount_of_users,
SUM(monthly_fee) AS total_monthly_revenue_without_discount
FROM subscriptions
GROUP BY plan_name
ORDER BY total_monthly_revenue DESC