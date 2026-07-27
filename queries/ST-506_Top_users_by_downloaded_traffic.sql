/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-506

Title:
Top 5 Users by Downloaded Traffic

Author:
Pavlo Kotenko

Description:
Display the top 5 users with the highest
number of downloaded gigabytes.

For each user show:

- first name
- last name
- country
- tariff plan
- downloaded gigabytes

Sort the result by downloaded traffic
in descending order.

Topics:
- INNER JOIN
- ORDER BY
- LIMIT

Expected Result:

first_name
last_name
country
plan_name
gb_downloaded

==========================================================
*/

SELECT
sc.first_name,
sc.last_name,
sc.country,
s.plan_name,
sc.gb_downloaded
FROM starlink_customers sc 
JOIN subscriptions s 
ON sc.unique_id = s.customer_id
ORDER BY sc.gb_downloaded DESC
LIMIT 5