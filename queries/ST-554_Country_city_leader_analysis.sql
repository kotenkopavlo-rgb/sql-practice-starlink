/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-554

Title:
Country City Leader Analysis

Author:
Pavlo Kotenko

Version:
1.0

Description:

The business team wants to identify the leading city
in each country by number of customers.

For each country determine:

1. The city with the highest number of customers.
2. The number of customers in that city.
3. The total number of customers in the country.
4. What percentage of the country's customers live in
   the leading city.

If several cities have the same number of customers,
select the city with the alphabetically first name.

Display:

- country
- leading_city
- city_users_count
- total_country_users
- city_share_percentage

Requirements:

- Use only the starlink_customers table.
- First calculate the number of customers for each
  country and city.
- Calculate the total number of customers for each
  country.
- Identify exactly one leading city for each country.
- Use ROW_NUMBER() to resolve ties.
- The primary sorting criterion is users_count DESC.
- If users_count is equal, sort city ASC.
- Calculate city_share_percentage as the percentage
  of customers in the leading city relative to all
  customers in the country.
- Round the percentage to 2 decimal places.
- Return exactly one row per country.
- Sort the final result by city_share_percentage DESC.

Topics:

- CTE
- GROUP BY
- COUNT
- JOIN
- ROW_NUMBER
- PARTITION BY
- ORDER BY
- Calculated fields
- Percentage
- Integer division
- ROUND
- Tie-breaking
==========================================================
*/

WITH list_of_cities_by_country AS (
SELECT
sc.country,
sc.city,
COUNT(*) AS city_users_count
FROM starlink_customers sc 
GROUP BY sc.country, sc.city 
),
total_amount_of_users_by_country AS (
SELECT
sc.country,
COUNT(*) AS total_country_users
FROM starlink_customers sc
GROUP BY sc.country 
),
merged_amout_by_cities_and_countries AS (
SELECT *
FROM list_of_cities_by_country l
JOIN total_amount_of_users_by_country t
ON t.country = l.country  
),
city_rank_determined AS (
SELECT
country,
ROW_NUMBER() OVER(
PARTITION BY country
ORDER BY city_users_count DESC, city ASC
) AS city_rank,
city,
city_users_count,
total_country_users,
(city_users_count * 1.0 / total_country_users) * 100.0 AS city_share_percentage 
FROM merged_amout_by_cities_and_countries
)
SELECT
country,
city AS leading_city,
city_users_count,
total_country_users,
ROUND(city_share_percentage,2) AS city_share_percentage 
FROM city_rank_determined
WHERE city_rank  = 1
ORDER BY city_share_percentage DESC






















