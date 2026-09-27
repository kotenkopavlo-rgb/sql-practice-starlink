/*
Project: SQL Practice – Starlink Analytics
Task: ST-567
Title: Customer Subscription Value Analysis
Author: Pavlo Kotenko
Version: 1.0

Description:
Analyze the relationship between customer subscription plans and
customer data usage.

Display:
- Customer ID
- Customer full name
- Country
- Subscription plan
- Subscription status
- Monthly fee
- Discount percentage
- Revenue after discount
- Total data usage
- Revenue per GB

Revenue after discount:
monthly_fee * (1 - discount_percent / 100.0)

Revenue per GB:
revenue_after_discount / total_data_usage

Requirements:
- Join starlink_customers with subscriptions.
- Combine first and last name into full name.
- Calculate revenue after discount.
- Calculate total data usage:
  gb_downloaded + gb_uploaded
- Calculate revenue per GB.
- Avoid division by zero.
- Round calculated financial metrics to two decimals.
- Sort customers by revenue per GB descending.

Topics:
JOIN
Arithmetic calculations
CTE
CASE
NULL handling
Division
ROUND
ORDER BY
*/

SELECT 
s.customer_id,
sc.first_name || " " || sc.last_name AS full_name,
sc.country,
s.plan_name AS subscription_plan,
s.status AS subscription_status,
s.monthly_fee,
s.discount_percent AS discount_percentage,
(s.monthly_fee * (1 - s.discount_percent / 100.0)) AS revenue_after_discount,
(sc.gb_downloaded + sc.gb_uploaded) AS total_usage,
ROUND((s.monthly_fee * (1 - s.discount_percent / 100.0)) / (sc.gb_downloaded + sc.gb_uploaded), 2) AS revenue_per_GB
FROM starlink_customers sc
JOIN subscriptions s 
ON sc.unique_id = s.customer_id 












