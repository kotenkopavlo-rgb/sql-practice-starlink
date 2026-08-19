/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-535

Title:
User Revenue vs Country Median

Author:
Pavlo Kotenko

Version:
1.0

Description:

Calculate each user's monthly revenue after applying
the subscription discount and compare it with the median
monthly revenue of users in the same country.

For each user, calculate:

1. Monthly revenue after discount.
2. Median monthly revenue for their country.
3. Difference between the user's revenue and the
   country median.
4. Percentage difference from the country median.

Monthly revenue:

monthly_fee * (1 - discount_percent / 100.0)

Revenue difference:

monthly_revenue - country_median_revenue

Percentage difference:

(monthly_revenue - country_median_revenue)
/
country_median_revenue * 100

Return only users whose monthly revenue is above
the median revenue of their country.

Important:

SQLite does not provide a built-in MEDIAN() function.
Determine the median using window functions and
appropriate ranking logic.

Display:

- first_name
- last_name
- country
- monthly_revenue
- country_median_revenue
- revenue_difference
- percentage_vs_median

Round calculated numeric values to 2 decimal places.

Topics:

- CTE
- JOIN
- Window Functions
- ROW_NUMBER()
- RANK()
- PARTITION BY
- ORDER BY
- COUNT()
- CASE WHEN
- ROUND()
- Calculated Fields

Expected Result:

first_name
last_name
country
monthly_revenue
country_median_revenue
revenue_difference
percentage_vs_median

==========================================================
*/

WITH user_monthly_revenue AS (
SELECT
sc.first_name,
sc.last_name,
sc.country,
s.monthly_fee * (1 - s.discount_percent / 100.0) AS monthly_revenue
FROM starlink_customers sc 
JOIN subscriptions s 
ON sc.unique_id = s.customer_id
),
rank_by_country AS (
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY country
ORDER BY monthly_revenue
) AS revenue_rank,
COUNT(*) OVER (
PARTITION BY country
) AS users_count
FROM user_monthly_revenue 
),
median_values AS (
SELECT
country,
monthly_revenue,
users_count
FROM rank_by_country
WHERE revenue_rank = (users_count + 1) / 2 OR revenue_rank = (users_count / 2) + 1
),
country_medians AS (
SELECT
country,
AVG(monthly_revenue) AS country_median_revenue
FROM median_values
GROUP BY country 
)
SELECT
u.first_name,
u.last_name,
u.country,
u.monthly_revenue,
c.country_median_revenue,
(u.monthly_revenue - c.country_median_revenue) AS revenue_difference,
ROUND((u.monthly_revenue - c.country_median_revenue) / c.country_median_revenue * 100.0 ,2) AS percentage_vs_median
FROM user_monthly_revenue u
JOIN country_medians c
ON c.country = u.country 
WHERE u.monthly_revenue > c.country_median_revenue 




















