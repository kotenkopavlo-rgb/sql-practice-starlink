/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-531

Title:
Country Revenue vs Global Average

Author:
Pavlo Kotenko

Version:
1.0

Description:

Calculate the total monthly revenue for each country
after applying discounts.

Then calculate the average monthly revenue across
all countries.

Display only countries whose total monthly revenue
is above the global average.

For each selected country, calculate how many percent
its revenue is above the global average.

Monthly revenue:

monthly_fee * (1 - discount_percent / 100.0)

Percentage above average:

(total_monthly_revenue - global_average_revenue)
/
global_average_revenue * 100

Display:

- country
- total_monthly_revenue
- global_average_revenue
- percentage_above_average

Return only countries where:

total_monthly_revenue > global_average_revenue

Topics:

- JOIN
- GROUP BY
- CTE
- AVG()
- CROSS JOIN
- Calculated Fields
- WHERE
- ROUND()

Expected Result:

country
total_monthly_revenue
global_average_revenue
percentage_above_average

==========================================================
*/

WITH monthly_revenue_by_countries AS (
SELECT
sc.country,
SUM((s.monthly_fee * (1 - (s.discount_percent / 100.0)))) AS monthly_revenue
FROM starlink_customers sc
JOIN subscriptions s 
ON sc.unique_id = s.customer_id  
GROUP BY sc.country
),
average_revenue_by_all_countries AS (
SELECT
-- sc.country,
AVG(monthly_revenue ) AS average_revenue
FROM monthly_revenue_by_countries 
),
countries_more_than_average_revenue AS (
SELECT *
FROM monthly_revenue_by_countries m 
CROSS JOIN average_revenue_by_all_countries a
WHERE m.monthly_revenue > a.average_revenue  
)
SELECT
country,
monthly_revenue AS total_monthly_revenue,
ROUND((((monthly_revenue / average_revenue) - 1) * 100.0),2) AS percentage_above_average
FROM countries_more_than_average_revenue 





















