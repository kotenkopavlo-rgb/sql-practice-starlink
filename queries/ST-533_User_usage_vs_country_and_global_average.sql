/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-533

Title:
User Usage vs Country and Global Average

Author:
Pavlo Kotenko

Version:
1.0

Description:

For each user, display their GB downloaded and compare
their usage with both the average usage in their country
and the global average usage.

Calculate:

1. Average GB downloaded by country.
2. Global average GB downloaded.
3. Percentage difference between the user's usage
   and the average usage in their country.

Percentage formula:

(user_gb - country_average_gb)
/
country_average_gb * 100

Return only users whose GB downloaded is above the
average for their country.

Display:

- first_name
- last_name
- country
- gb_downloaded
- country_average_gb
- global_average_gb
- percentage_vs_country_average

Round:

- country_average_gb to 2 decimal places
- global_average_gb to 2 decimal places
- percentage_vs_country_average to 2 decimal places

Topics:

- CTE
- JOIN
- CROSS JOIN
- GROUP BY
- AVG()
- Calculated Fields
- WHERE
- ROUND()

Expected Result:

first_name
last_name
country
gb_downloaded
country_average_gb
global_average_gb
percentage_vs_country_average

==========================================================
*/

WITH average_gb_downloaded_by_country AS (
SELECT
sc.country,
ROUND(AVG(sc.gb_downloaded),2) AS country_average_gb
FROM starlink_customers sc
GROUP BY sc.country
),
user_information AS (
SELECT 
sc.first_name,
sc.last_name,
sc.country,
sc.gb_downloaded,
a.country_average_gb 
FROM starlink_customers sc
LEFT JOIN average_gb_downloaded_by_country a
ON sc.country = a.country 
),
global_average_downloaded AS (
SELECT
ROUND(AVG (sc.gb_downloaded ),2) AS global_average_gb
FROM starlink_customers sc 
)
SELECT *,
ROUND((gb_downloaded - country_average_gb)/country_average_gb * 100.0,2) AS percentage
FROM user_information
CROSS JOIN global_average_downloaded 
WHERE gb_downloaded > country_average_gb 

































