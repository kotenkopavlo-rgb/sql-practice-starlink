/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-519

Title:
Top 3 Downloaders per Country

Author:
Pavlo Kotenko

Version:
1.0

Description:

For each country display the TOP 3 users
with the highest downloaded traffic.

Display:

- first_name
- last_name
- country
- gb_downloaded
- download_rank

Topics:

- CTE
- ROW_NUMBER()
- Window Functions

Expected Result:

first_name
last_name
country
gb_downloaded
download_rank

Maximum three users per country.

==========================================================
*/

WITH top_3_users_per_gb_downloaded AS (
SELECT
sc.first_name,
sc.last_name,
sc.country,
sc.gb_downloaded,
ROW_NUMBER() OVER(
PARTITION BY country
ORDER BY gb_downloaded DESC
) AS top_3_users
FROM starlink_customers sc
)
SELECT *
FROM top_3_users_per_gb_downloaded
WHERE top_3_users <= 3
