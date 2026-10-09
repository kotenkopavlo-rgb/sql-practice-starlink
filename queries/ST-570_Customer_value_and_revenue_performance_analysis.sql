/*
Project: SQL Practice – Starlink Analytics
Task: ST-570
Title: Customer Value & Revenue Performance Analysis
Author: Pavlo Kotenko
Version: 1.0

Description:
Analyze customer revenue performance and compare each customer's
revenue with the average revenue of customers in the same country.

Display:

Customer ID

Customer full name

Country

Number of subscriptions

Total revenue after discount

Average revenue per subscription

Country average customer revenue

Difference from country average

Revenue performance category

Revenue after discount:
monthly_fee * (1 - discount_percent / 100.0)

Requirements:

Join starlink_customers with subscriptions.

Calculate total revenue after discount for each customer.

Calculate the number of subscriptions per customer.

Calculate average revenue per subscription.

Calculate average customer revenue within each country.

Calculate the difference between customer revenue and country average.

Classify customers using CASE:

Above Average — revenue is greater than country average.

Below Average — revenue is lower than country average.

Average — revenue equals country average.

Round revenue metrics to two decimal places.

Sort by country and total revenue after discount descending.

Topics:
JOIN
CTE
GROUP BY
SUM
COUNT
AVG
CASE
Window functions
PARTITION BY
ROUND
ORDER BY
*/

WITH user_statistic AS (
SELECT
sc.unique_id AS customer_id,
(sc.first_name || ' ' || sc.last_name) AS full_name,
sc.country,
COUNT(s.subscription_id) AS subscriptions_count,
SUM(s.monthly_fee * (1 - s.discount_percent /100.0)) AS total_revenue,
AVG(s.monthly_fee * (1 - s.discount_percent /100.0)) AS avg_revenue_per_subscription
FROM starlink_customers sc
JOIN subscriptions s 
ON sc.unique_id = s.customer_id
GROUP BY sc.unique_id, sc.first_name, sc.last_name, sc.country  
),
country_comparison AS (
SELECT *,
AVG(total_revenue) OVER(
PARTITION BY country 
) AS country_avg_revenue
FROM user_statistic 
),
customer_performance AS (
SELECT *,
(total_revenue - country_avg_revenue) AS difference_from_country_average,
CASE
WHEN 	(total_revenue - country_avg_revenue) > 0 THEN "Above average"
WHEN 	(total_revenue - country_avg_revenue) < 0 THEN "Below average"
WHEN 	(total_revenue - country_avg_revenue) = 0 THEN "Average"
END AS revenue_performance_category
FROM country_comparison 
)
SELECT
customer_id,
full_name,
country,
subscriptions_count,
total_revenue,
avg_revenue_per_subscription,
ROUND(country_avg_revenue, 2) AS country_avg_revenue,
ROUND(difference_from_country_average, 2) AS difference_from_country_average,
revenue_performance_category 
FROM customer_performance  
ORDER BY country, total_revenue DESC




