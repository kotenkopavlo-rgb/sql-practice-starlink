/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-532

Title:
High-Usage Users by Country

Author:
Pavlo Kotenko

Version:
1.0

Description:

For each country, calculate:

1. The average amount of GB downloaded by users.
2. The number of users whose GB downloaded is above
   the average for their country.
3. The percentage of users whose GB downloaded is above
   the country average.

Display:

- country
- total_users
- average_gb_downloaded
- high_usage_users
- high_usage_percentage

Where:

high_usage_users =
number of users whose gb_downloaded is greater than
the average gb_downloaded for their country.

Formula:

high_usage_percentage =
high_usage_users / total_users * 100

Round:

- average_gb_downloaded to 2 decimal places
- high_usage_percentage to 2 decimal places

Return exactly ONE row per country.

Topics:

- GROUP BY
- CTE
- AVG()
- COUNT()
- CASE WHEN
- JOIN / CTE JOIN
- ROUND()
- Aggregate Functions

Expected Result:

country
total_users
average_gb_downloaded
high_usage_users
high_usage_percentage

==========================================================
*/

WITH average_gb_downloaded_by_country AS (
SELECT
sc.country,
AVG(sc.gb_downloaded ) AS average_gb_downloaded
FROM starlink_customers sc
GROUP BY sc.country
),
users_above_average_gb_downloaded AS (
SELECT *,
CASE
	WHEN gb_downloaded > average_gb_downloaded THEN 'above'
	ELSE 'low'
END AS 'User_category'
FROM starlink_customers sc
JOIN average_gb_downloaded_by_country a
ON sc.country = a.country 
),
amount_of_high_usage_users AS (
SELECT
country,
COUNT(user_category) AS high_usage_users
FROM users_above_average_gb_downloaded
WHERE User_category = 'above'
GROUP BY country
),
merge_all_tables AS (
SELECT 
u.country,
COUNT(u.User_category) AS total_users,
ROUND(u.average_gb_downloaded,2) AS average_gb_downloaded,
COALESCE(a.high_usage_users, 0) AS high_usage_users
FROM  users_above_average_gb_downloaded u
LEFT JOIN amount_of_high_usage_users a 
ON u.country  = a.country
GROUP BY u.country 
)
SELECT
m.country,
m.total_users,
m.average_gb_downloaded,
m.high_usage_users,
ROUND(((m.high_usage_users * 1.0 / m.total_users) * 100.0),2) AS percentage
FROM merge_all_tables m 







