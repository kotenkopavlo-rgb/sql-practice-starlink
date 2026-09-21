/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-564

Title:
Subscription Plan Revenue Analysis

Author:
Pavlo Kotenko

Version:
1.0

Description:

Analyze subscription performance by subscription plan.

The report should show how many subscriptions each plan has,
how much revenue the plan generates, and what share of the
total revenue it represents.

Revenue after discount should be used as the main revenue
metric.

Display:

- Subscription plan
- Number of subscriptions
- Gross revenue
- Revenue after discount
- Average revenue per subscription
- Percentage of total revenue

Requirements:

- Use the subscriptions table.
- Group subscriptions by plan_name.
- Count the number of subscriptions for each plan.
- Calculate gross revenue as the SUM of monthly_fee.
- Calculate revenue after discount using:
  monthly_fee * (1 - discount_percent / 100.0)
- Calculate average revenue per subscription after discount.
- Calculate each plan's percentage of total revenue after
  discount.
- Use a CTE to calculate total revenue after discount.
- Use CROSS JOIN to make total revenue available for
  percentage calculations.
- Round revenue, average revenue, and percentage values
  to two decimal places only in the final SELECT.
- Sort the result by revenue after discount in descending
  order.

Topics:

- CTE
- GROUP BY
- COUNT()
- SUM()
- AVG()
- CROSS JOIN
- Revenue calculations
- Discount calculations
- Percentage calculations
- Aggregate functions
- Rounding

==========================================================
*/
WITH statistic_by_tariff_plan AS (
SELECT 
s.plan_name,
COUNT(*) AS subscriptions,
SUM(s.monthly_fee ) AS gross_revenue,
SUM(s.monthly_fee * (1 - (s.discount_percent / 100.0))) AS revenue_after_discount
FROM starlink_customers sc
JOIN subscriptions s
ON sc.unique_id = s.customer_id
GROUP BY plan_name
),
total_revenue AS (
SELECT
SUM(s.monthly_fee * (1 - s.discount_percent / 100.0)) AS total_revenue
FROM starlink_customers sc
JOIN subscriptions s
ON sc.unique_id = s.customer_id
)
SELECT
plan_name,
subscriptions,
gross_revenue,
revenue_after_discount,
ROUND((revenue_after_discount / subscriptions), 2) AS avg_revenue,
ROUND(((revenue_after_discount / total_revenue) * 100.0), 2) AS percent_total_revenue
FROM statistic_by_tariff_plan
CROSS JOIN total_revenue
ORDER BY revenue_after_discount DESC


















