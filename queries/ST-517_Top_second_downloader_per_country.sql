/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-517

Title:
Second Highest Downloader per Country

Author:
Pavlo Kotenko

Version:
1.0

Description:

For each country display the customer
who has the SECOND highest downloaded traffic.

Display:

- first_name
- last_name
- country
- gb_downloaded

Topics:

- CTE
- ROW_NUMBER()
- Window Functions

Expected Result:

first_name
last_name
country
gb_downloaded

Exactly one customer per country.

==========================================================
*/

WITH top_second_user_by_country AS(
SELECT
sc.first_name,
sc.last_name,
sc.country,
sc.gb_downloaded,
ROW_NUMBER() OVER (
PARTITION BY sc.country
ORDER BY gb_downloaded DESC
) AS rating
FROM starlink_customers sc
)
SELECT *
FROM top_second_user_by_country
WHERE rating = 2 

















