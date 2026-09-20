/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-563

Title:
Monthly Subscription Revenue Analysis

Author:
Pavlo Kotenko

Version:
1.0

Description:

Analyze monthly subscription revenue using customer
subscription data.

Revenue should be calculated using the monthly subscription
fee and the applicable discount.

The report should show how revenue changes from month to
month.

Display:

- Revenue month
- Number of subscriptions
- Gross monthly revenue
- Revenue after discount
- Previous month revenue
- Revenue difference from previous month
- Monthly revenue growth percentage

Requirements:

- Join starlink_customers with subscriptions using:
  starlink_customers.unique_id = subscriptions.customer_id
- Extract the month from subscription start_date
  in YYYY-MM format.
- Count the number of subscriptions for each month.
- Calculate gross monthly revenue using monthly_fee.
- Calculate revenue after discount using:
  monthly_fee * (1 - discount_percent / 100.0)
- Calculate previous month revenue using LAG().
- Calculate the difference between current and previous
  month revenue.
- Calculate monthly revenue growth percentage.
- For the first month, previous revenue and growth
  percentage should be NULL.
- Avoid division by zero when calculating growth.
- Use CTEs to keep the query readable.
- Do not round intermediate calculations.
- Round revenue and percentage values to two decimal places
  only in the final SELECT.
- Sort the result chronologically by revenue month.

Topics:

- JOIN
- CTE
- SUBSTR()
- GROUP BY
- SUM()
- COUNT()
- LAG()
- Window functions
- Revenue calculations
- Discount calculations
- Percentage calculations
- NULL handling
- Integer division
- Rounding

==========================================================
*/

WITH subscription_revenue AS (
SELECT
s.subscription_id,
s.customer_id,
s.start_date,
SUBSTR(sc.sign_contract_date_raw  , 1, 7) AS revenue_month, 
s.monthly_fee,
s.discount_percent,
(s.monthly_fee * (1 - s.discount_percent / 100.0)) AS revenue_after_discount
FROM starlink_customers sc 
JOIN subscriptions s 
ON sc.unique_id = s.customer_id
),
monthly_revenue AS (
SELECT
revenue_month,
COUNT(*) AS subscriptions_count,
SUM(monthly_fee) AS gross_monthly_revenue,
SUM(revenue_after_discount) AS revenue_after_discount
FROM subscription_revenue 
GROUP BY revenue_month 
),
lag_with_previous_month AS (
SELECT *,
LAG(revenue_after_discount) OVER (
ORDER BY revenue_month 
) AS previous_month_revenue
FROM monthly_revenue 
)
SELECT
revenue_month,
subscriptions_count,
gross_monthly_revenue,
revenue_after_discount,
previous_month_revenue,
(revenue_after_discount - previous_month_revenue) AS revenue_difference,
ROUND((((revenue_after_discount - previous_month_revenue) * 1.0 / previous_month_revenue)) * 100.0, 2) AS growth_percentage
FROM lag_with_previous_month 



















