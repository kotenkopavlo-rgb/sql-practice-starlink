/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-542

Title:
Customer Usage vs Country Average

Author:
Pavlo Kotenko

Version:
1.0

Description:

Analyze individual customer data usage and compare each
user's downloaded data with the average usage of their
country.

For each user, calculate:

1. Amount of downloaded data.
2. Average GB downloaded by users in the same country.
3. Difference between the user's usage and the country
   average.
4. Percentage difference from the country average.
5. Usage category.
6. Usage rank within the country.

Country average usage:

AVG(gb_downloaded)

Difference from average:

gb_downloaded - country_average_gb

Usage percentage vs average:

(gb_downloaded - country_average_gb)
/
country_average_gb * 100

Usage categories:

Heavy User:
gb_downloaded >= country_average_gb * 1.50

Above Average:
gb_downloaded > country_average_gb
AND
gb_downloaded < country_average_gb * 1.50

Average:
gb_downloaded = country_average_gb

Below Average:
gb_downloaded < country_average_gb

Usage ranking:

Rank users within each country by gb_downloaded in
descending order.

Users with the same gb_downloaded value must receive
the same rank.

Display:

- first_name
- last_name
- country
- gb_downloaded
- country_average_gb
- difference_from_average
- usage_percentage_vs_average
- usage_category
- usage_rank

Round calculated values to 2 decimal places.

Sort the final results by:

1. country ASC
2. usage_rank ASC

Topics:

- CTE
- JOIN
- GROUP BY
- AVG()
- CASE WHEN
- RANK()
- PARTITION BY
- ORDER BY
- Calculated Fields
- Percentage Calculations
- ROUND()

==========================================================
*/

WITH user_statistic AS (
SELECT
sc.first_name,
sc.last_name,
sc.country,
sc.gb_downloaded 
FROM starlink_customers sc
),
average_gb_downloaded_by_country AS (
SELECT
sc.country,
AVG(sc.gb_downloaded) AS country_average_gb
FROM starlink_customers sc 
GROUP BY country 
),
comparisson_between_country_and_user AS (
SELECT *,
(u.gb_downloaded - a.country_average_gb) AS difference_from_average,
(u.gb_downloaded - a.country_average_gb) / a.country_average_gb * 100.0 AS usage_percentage_vs_average,
CASE
	WHEN gb_downloaded >= a.country_average_gb * 1.50 THEN 'Heavy_user'
	WHEN gb_downloaded = a.country_average_gb THEN 'Average'
	WHEN gb_downloaded >= a.country_average_gb THEN 'Above average'
	ELSE 'Below_average'
END AS 'usage_category'
FROM user_statistic u   
JOIN average_gb_downloaded_by_country a 
ON a.country = u.country
)
SELECT
first_name,
last_name,
country,
gb_downloaded,
ROUND(country_average_gb,2) AS country_average_gb,
ROUND(difference_from_average,2) AS difference_from_average,
ROUND(usage_percentage_vs_average,2) AS usage_percentage_vs_average,
usage_category,
DENSE_RANK() OVER (
PARTITION BY country
ORDER BY gb_downloaded DESC
) AS usage_rank
FROM comparisson_between_country_and_user 





























