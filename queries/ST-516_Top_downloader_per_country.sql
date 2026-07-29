/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-516

Title:
Top Downloader per Country

Description:

For each country display ONLY the customer
who downloaded the largest amount of traffic.

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

One customer per country.

==========================================================
*/

WITH top_users_by_gb_downloaded AS(
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
FROM top_users_by_gb_downloaded
WHERE  rating = 1

