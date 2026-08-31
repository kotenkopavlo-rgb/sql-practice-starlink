/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-546

Title:
Customer Revenue Leaders

Author:
Pavlo Kotenko

Version:
1.0

Description:

Identify the most valuable customer in each country based
on monthly revenue after applying the subscription
discount.

For each country, select only one customer with the highest
monthly revenue.

Monthly revenue:

monthly_fee * (1 - discount_percent / 100.0)

Country average revenue:

Average monthly revenue of all users within the same
country.

Revenue difference:

monthly_revenue - country_average_revenue

Revenue vs average percentage:

(monthly_revenue - country_average_revenue)
/
country_average_revenue * 100

Customer selection:

Rank customers within each country by the following
criteria:

1. monthly_revenue DESC
2. gb_downloaded DESC
3. unique_id ASC

The customer ranked first must be selected.

This means:

- Higher monthly revenue has priority.
- If monthly revenue is equal, higher data usage has
  priority.
- If both values are equal, the customer with the smaller
  unique_id has priority.

Display:

- country
- first_name
- last_name
- plan_name
- monthly_revenue
- country_average_revenue
- revenue_difference
- revenue_vs_average_percent

Round calculated values to 2 decimal places.

Sort the final results by monthly_revenue in descending
order.

Topics:

- CTE
- JOIN
- AVG()
- ROW_NUMBER()
- Window Functions
- PARTITION BY
- Multiple ORDER BY criteria
- Calculated Fields
- Percentage Calculations
- ROUND()

==========================================================
*/

WITH customer_statistic AS (
SELECT
sc.country,
sc.first_name,
sc.last_name,
s.plan_name,
(s.monthly_fee * 1 - s.discount_percent / 100.0) AS monthly_revenue,
sc.gb_downloaded,
sc.unique_id 
FROM starlink_customers sc 
JOIN subscriptions s 
ON sc.unique_id = s.customer_id
),
average_revenue_by_country AS (
SELECT 
sc.country,
AVG(s.monthly_fee * 1 - s.discount_percent / 100.0) AS country_average_revenue
FROM starlink_customers sc 
JOIN subscriptions s 
ON sc.unique_id = s.customer_id
GROUP BY sc.country 
),
top_customers_by_country AS (
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY c.country
ORDER BY c.monthly_revenue  DESC, c.gb_downloaded DESC, c.unique_id ASC
) AS top_rank
FROM customer_statistic c 
JOIN average_revenue_by_country a
ON c.country = a.country 
)
SELECT
country,
first_name,
last_name,
plan_name,
monthly_revenue,
ROUND(country_average_revenue,2) AS country_average_revenue,
ROUND((monthly_revenue - country_average_revenue),2) AS revenue_difference,
ROUND(((monthly_revenue - country_average_revenue) / country_average_revenue * 100.0),2) AS revenue_vs_average_percent
FROM top_customers_by_country  
WHERE top_rank = 1








