/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-537

Title:
Customer Usage Segmentation

Author:
Pavlo Kotenko

Version:
1.0

Description:

Segment Starlink customers by their monthly data usage
and analyze the distribution of users across countries.

For each user, assign a usage category based on the
amount of GB downloaded:

High:
gb_downloaded >= 500

Medium:
gb_downloaded >= 200 AND gb_downloaded < 500

Low:
gb_downloaded < 200

For each country, calculate:

1. Total number of users.
2. Number of high-usage users.
3. Number of medium-usage users.
4. Number of low-usage users.
5. Percentage of high-usage users among all users.

High-usage percentage:

high_usage_users / total_users * 100

Display:

- country
- total_users
- high_usage_users
- medium_usage_users
- low_usage_users
- high_usage_percentage

Round percentage values to 2 decimal places.

Sort the results by high_usage_percentage in descending
order.

Topics:

- CTE
- CASE WHEN
- Conditional Aggregation
- COUNT()
- SUM()
- GROUP BY
- ROUND()
- Calculated Fields
- ORDER BY

==========================================================
*/

WITH category_of_users AS (
SELECT
country,
COUNT(*) AS total_users,
COUNT(
        CASE
            WHEN gb_downloaded >= 500 THEN 1
        END
    ) AS high_usage_users,
COUNT(
        CASE
            WHEN gb_downloaded < 200 THEN 1
        END
    ) AS low_usage_users
FROM starlink_customers sc
GROUP BY sc.country
),
final_usage_segmentation AS (
SELECT
country,
total_users,
high_usage_users,
(total_users - (high_usage_users + low_usage_users )) AS medium_usage_users,
low_usage_users,
ROUND(((high_usage_users *1.0/ total_users) * 100.0),2) AS high_usage_percentage
FROM category_of_users 
)
SELECT *
FROM final_usage_segmentation  
ORDER BY high_usage_percentage DESC













