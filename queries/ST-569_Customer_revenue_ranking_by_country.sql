/*
Project: SQL Practice – Starlink Analytics
Task: ST-569
Title: Customer Revenue Ranking by Country
Author: Pavlo Kotenko
Version: 1.0

Description:
Rank customers by their total subscription revenue within each country.

Revenue after discount is the main revenue metric.

Display:
- Customer ID
- Customer full name
- Country
- Total revenue after discount
- Country revenue rank
- Country revenue percentile

Requirements:
- Join starlink_customers with subscriptions.
- Calculate total revenue after discount for each customer.
- Use a window function to rank customers within each country.
- Customers with equal revenue should receive the same rank.
- Calculate the percentage of customers in the country whose
  revenue is lower than or equal to the current customer.
- Round the percentile to two decimals.
- Sort results by country and revenue rank.

Ranking:
Use RANK() with PARTITION BY country.

Revenue percentile:
Use a window function to calculate the customer's relative position
within their country.

Topics:
JOIN
GROUP BY
CTE
RANK()
PARTITION BY
COUNT() OVER
Window functions
Percentage calculations
ROUND
ORDER BY
*/

WITH statistic_by_user AS (
SELECT
sc.unique_id AS customer_id,
sc.first_name || ' ' || sc.last_name AS full_name,
sc.country,
s.monthly_fee * (1 - s.discount_percent / 100.0) AS total_revenue_after_discount
FROM starlink_customers sc
JOIN subscriptions s
ON sc.unique_id = s.customer_id
),
rank_user_by_country AS (
SELECT *,
RANK() OVER (
PARTITION BY country
ORDER BY total_revenue_after_discount DESC
) AS revenue_rank,
COUNT(*) OVER (
PARTITION BY country
) AS customers_in_country
FROM statistic_by_user
),
customer_percentile AS (
SELECT *,
ROUND(((customers_in_country - revenue_rank + 1) * 100.0/ customers_in_country), 2) AS revenue_percentile
FROM rank_user_by_country
)
SELECT
customer_id,
full_name,
country,
ROUND(total_revenue_after_discount, 2) AS total_revenue_after_discount,
revenue_rank,
revenue_percentile
FROM customer_percentile
ORDER BY country, revenue_rank;


