/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-502

Title:
Discount Statistics

Author:
Pavlo Kotenko

Version:
1.0

Description:
For each tariff plan display:

- number of users
- original monthly fee
- minimum discounted price
- maximum discounted price
- average discounted price

Topics:
- GROUP BY
- MIN
- MAX
- AVG
- ROUND

Expected Result:

plan_name
amount_of_users
monthly_fee
min_value
max_value
average_value

==========================================================
*/

SELECT
plan_name,
COUNT(*) AS amount_of_users,
ROUND(MIN(monthly_fee * (1 - discount_percent / 100.0)), 2) AS min_value,
ROUND(MAX(monthly_fee * (1 - discount_percent / 100.0)), 2) AS max_value,
ROUND(AVG(monthly_fee * (1 - discount_percent / 100.0)), 2) AS average_value
FROM subscriptions
GROUP BY plan_name
