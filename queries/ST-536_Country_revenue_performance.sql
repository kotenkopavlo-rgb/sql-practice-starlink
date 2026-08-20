/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-536

Title:
Country Revenue Performance

Author:
Pavlo Kotenko

Version:
1.0

Description:

Analyze monthly revenue by country and identify countries
where the average monthly revenue per user is higher than
the global average.

For each country, calculate:

1. Number of users.
2. Total monthly revenue after discounts.
3. Average monthly revenue per user.
4. Global average monthly revenue per user.
5. Percentage difference between the country's average
   revenue per user and the global average.

Monthly revenue per user:

monthly_fee * (1 - discount_percent / 100.0)

Total country revenue:

SUM(monthly_revenue)

Average revenue per user:

country_total_revenue / users_count

Percentage difference from global average:

(country_average_revenue - global_average_revenue)
/
global_average_revenue * 100

Filter:

Return only countries where the average monthly revenue
per user is higher than the global average.

Sort the result by percentage difference from the global
average in descending order.

Display:

- country
- users_count
- country_total_revenue
- country_average_revenue
- global_average_revenue
- percentage_vs_global_average

Round calculated percentage values to 2 decimal places.

Topics:

- CTE
- JOIN
- CROSS JOIN
- GROUP BY
- COUNT()
- SUM()
- AVG()
- ROUND()
- Calculated Fields
- WHERE
- ORDER BY

==========================================================
*/

WITH statistics_by_country AS (
SELECT
sc.country,
COUNT(*) AS users_count,
SUM((s.monthly_fee * (1 - s.discount_percent / 100.0))) AS total_revenue_by_country,
ROUND(AVG((s.monthly_fee * 1 - s.discount_percent / 100.0)),2) AS average_revenue_by_country
FROM starlink_customers sc
JOIN subscriptions s 
ON sc.unique_id = s.customer_id
GROUP BY sc.country 
),
global_average_revenue AS (
SELECT
ROUND(AVG((s.monthly_fee * 1 - s.discount_percent / 100.0)),2) AS global_avg_revenue
FROM subscriptions s 
)
SELECT
s.country,
s.users_count,
s.total_revenue_by_country,
s.average_revenue_by_country,
g.global_avg_revenue,
ROUND(((s.average_revenue_by_country - g.global_avg_revenue) / g.global_avg_revenue * 100.0),2) AS percentage_vs_global_average
FROM statistics_by_country s
CROSS JOIN global_average_revenue g
WHERE s.average_revenue_by_country > global_avg_revenue 
ORDER BY percentage_vs_global_average DESC

























