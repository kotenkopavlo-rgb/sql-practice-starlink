/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-560

Title:
Monthly Customer Trend Signals

Author:
Pavlo Kotenko

Version:
1.0

Description:

Analyze monthly customer sign-ups and identify the main
trend signals for each month.

The report should compare the current number of customers
with the previous month and with the three-month moving
average.

Display:

- Sign-up month
- Number of customers
- Number of customers in the previous month
- Difference from the previous month
- Three-month moving average
- Difference from the moving average
- Monthly growth direction
- Trend status

Requirements:

- Extract the sign-up month in YYYY-MM format.
- Calculate the number of customers for each month.
- Use LAG() to get the number of customers from the previous month.
- Calculate the difference between the current and previous month.
- Calculate a three-month moving average using AVG() OVER().
- Calculate the difference between the current number of
  customers and the moving average.
- Use CASE to classify the monthly growth direction:
    - 'Growth' if the current value is greater than the previous month
    - 'Decline' if the current value is lower than the previous month
    - 'No Change' if the values are equal
    - NULL for the first month
- Use CASE to classify the trend status:
    - 'Above Trend' if the current value is greater than
      the three-month moving average
    - 'Below Trend' if the current value is lower than
      the three-month moving average
    - 'On Trend' if the values are equal
- Round the moving average and calculated differences
  to two decimal places only in the final SELECT.
- Sort the result by sign-up month in ascending order.
- Use CTEs to keep the query readable.
- Do not compare rounded values when calculating the
  trend status.

Topics:

- CTE
- SUBSTR()
- GROUP BY
- LAG()
- AVG() OVER()
- Window frames
- CASE WHEN
- NULL handling
- Date-based grouping
- Trend analysis
- Rounding calculated values

==========================================================
*/

WITH users_by_month AS (
SELECT
SUBSTR(sc.sign_contract_date_raw, 1, 7) AS sign_up_month,
COUNT(*) AS users_count
FROM starlink_customers sc 
GROUP BY sign_up_month 
),
comparison_with_previous_month AS (
SELECT *,
LAG(users_count ) OVER (
ORDER BY sign_up_month 
) AS previous_month_users
FROM users_by_month
),
comparison_with_three_months AS (
SELECT *,
(users_count - previous_month_users) AS difference_from_the_previous_month,
AVG(users_count ) OVER (
ORDER BY sign_up_month 
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
) AS three_month_moving_average
FROM comparison_with_previous_month
)
SELECT
sign_up_month,
users_count,
previous_month_users,
difference_from_the_previous_month,
ROUND(three_month_moving_average, 2) AS three_month_moving_average,
ROUND((users_count - three_month_moving_average), 2) AS difference_from_the_moving_average,
CASE
WHEN previous_month_users IS NULL THEN NULL
WHEN users_count > previous_month_users THEN 'Growth'
WHEN users_count < previous_month_users THEN 'Decline'
ELSE 'No Change'
END AS monthly_growth_direction,
CASE
WHEN users_count > three_month_moving_average THEN 'Above Trend'
WHEN users_count < three_month_moving_average THEN 'Below Trend'
ELSE 'On Trend'
END AS trend_status
FROM comparison_with_three_months
ORDER BY sign_up_month 














