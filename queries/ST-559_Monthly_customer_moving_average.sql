/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-559

Title:
Monthly Customer Moving Average

Author:
Pavlo Kotenko

Version:
1.0

Description:

The business team wants to smooth out short-term
fluctuations in monthly customer registrations and
identify the general trend.

Analyze the number of newly registered customers
by month and calculate a three-month moving average.

For each month calculate:

1. Number of newly registered customers.
2. Three-month moving average of new customers.
3. Difference between the current month's users_count
   and the three-month moving average.

For the first two months, when three complete months
are not available, the moving average should be based
on the available previous and current months.

Display:

- sign_up_month
- users_count
- three_month_moving_average
- difference_from_moving_average

Requirements:

- Use only the starlink_customers table.
- Use sign_contract_date_raw as the source date.
- Extract the month in YYYY-MM format.
- Group customers by sign-up month.
- Calculate the moving average using AVG() as a window
  function.
- The window must include the current row and the
  previous two rows.
- Sort the window chronologically by sign_up_month.
- Round the moving average to 2 decimal places.
- Calculate difference_from_moving_average as:
  users_count - three_month_moving_average.
- Round difference_from_moving_average to 2 decimal places.
- Sort the final result chronologically by sign_up_month.

Topics:

- CTE
- SUBSTR
- COUNT
- GROUP BY
- Window Functions
- AVG() OVER()
- ROWS BETWEEN
- Moving average
- Calculated fields
- ROUND
- ORDER BY

==========================================================
*/

WITH users_by_month AS (
SELECT
SUBSTR(sign_contract_date_raw, 1, 7) AS sign_up_month,
COUNT(*) AS users_count
FROM starlink_customers sc 
GROUP BY sign_up_month 
),
average_calculate AS (
SELECT *,
AVG(users_count) OVER (
ORDER BY sign_up_month
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
) AS three_month_moving_average
FROM users_by_month 
)
SELECT
sign_up_month,
users_count,
ROUND(three_month_moving_average, 2) AS three_month_moving_average,
ROUND((users_count - three_month_moving_average), 2) AS difference_from_moving_average
FROM average_calculate
ORDER BY sign_up_month














