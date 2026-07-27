/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-507

Title:
Top 3 Users by Country

Author:
Pavlo Kotenko

Version:
1.0

Description:
Display the three users with the highest
number of downloaded gigabytes for
each country.

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

==========================================================
*/

WITH ranked_users AS(
SELECT
first_name,
last_name,
country,
gb_downloaded, 
ROW_NUMBER() OVER (
PARTITION BY country
ORDER BY gb_downloaded DESC
) AS download_rank
FROM starlink_customers
)
SELECT *
FROM ranked_users
WHERE download_rank < 4