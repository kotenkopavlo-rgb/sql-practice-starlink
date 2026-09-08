/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-553

Title:
Customer Distribution by City

Author:
Pavlo Kotenko

Version:
1.0

Description:

The business team wants to understand how customers are
distributed across cities within each country.

Your task is to analyze the number of customers in each
city and determine how significant each city is within
its country.

For each country and city calculate:

1. Number of customers in the city.
2. Percentage of the country's customers living in that city.
3. Rank of the city within its country by customer count.

The city with the highest number of customers in each
country should have rank 1.

If two or more cities have the same number of customers,
they should receive the same rank.

Display:

- country
- city
- users_count
- city_share_percentage
- city_rank

Requirements:

- Use only the starlink_customers table.
- Calculate the total number of customers separately
  for each country.
- Calculate city_share_percentage as the percentage of
  customers in the city relative to all customers in
  that country.
- Round the percentage to 2 decimal places.
- Rank cities within each country by users_count DESC.
- Cities with the same users_count must receive the same
  rank.
- Sort the final result by country ASC, city_rank ASC,
  city ASC.

Topics:

- CTE
- GROUP BY
- COUNT
- Window Functions
- RANK
- PARTITION BY
- JOIN
- Calculated fields
- Percentage
- Integer division
- ROUND
- ORDER BY

==========================================================
*/

WITH group_by_city_in_a_country AS (
SELECT
sc.country,
sc.city,
COUNT(*) AS users_count
FROM starlink_customers sc 
GROUP BY sc.country, sc.city 
ORDER BY sc.country, users_count DESC
),
group_by_country AS (
SELECT
sc.country,
COUNT(*) AS total_users_count
FROM starlink_customers sc
GROUP BY country 
) 
SELECT
gp.country,
g.city,
g.users_count,
ROUND(((g.users_count * 1.0 / gp.total_users_count) * 100.0),2) AS city_share_percentage,
RANK() OVER(
PARTITION BY g.country
ORDER BY g.users_count DESC
) AS city_rank
FROM group_by_city_in_a_country g
JOIN group_by_country gp
ON g.country = gp.country  



















