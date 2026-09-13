/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-558

Title:
Monthly Customer Growth Analysis

Author:
Pavlo Kotenko

Version:
1.0

Description:

The business team wants to understand how the number
of new customers changes from month to month.

Analyze customer contract signing dates and calculate
monthly customer growth.

For each month calculate:

1. Number of newly registered customers.
2. Number of customers registered in the previous month.
3. Absolute difference from the previous month.
4. Percentage change compared with the previous month.

For the first month, where no previous month exists,
the previous-month values should be NULL.

Display:

- sign_up_month
- users_count
- previous_month_users
- users_difference
- users_growth_percentage

Requirements:

- Use only the starlink_customers table.
- Use sign_contract_date_raw as the source date.
- Extract the month in YYYY-MM format.
- Group customers by sign-up month.
- Use LAG() to retrieve the number of users from the
  previous month.
- Calculate users_difference as:
  users_count - previous_month_users.
- Calculate users_growth_percentage as:
  (users_difference / previous_month_users) * 100.
- Avoid integer division.
- Round users_growth_percentage to 2 decimal places.
- For the first month, users_difference and
  users_growth_percentage should be NULL.
- If previous_month_users = 0, avoid division by zero.
- Sort the final result chronologically by sign_up_month.

Topics:

- CTE
- String functions
- SUBSTR
- COUNT
- GROUP BY
- Window Functions
- LAG
- Calculated fields
- Percentage change
- Integer division
- NULL
- ROUND
- CASE
- ORDER BY

==========================================================
*/

WITH users_by_month AS (
SELECT 
SUBSTR(sc.sign_contract_date_raw, 1, 7) AS sign_up_month,
COUNT(*) AS users_count
FROM starlink_customers sc
GROUP BY sign_up_month
),
monthly_growth AS (
SELECT *,
LAG(users_count) OVER (
ORDER BY sign_up_month 
) AS previous_month_users
FROM users_by_month 
)
SELECT
sign_up_month,
users_count,
previous_month_users,
(users_count - previous_month_users ) AS users_difference,
ROUND((((users_count - previous_month_users ) * 1.0)/previous_month_users * 100.0),2) AS users_growth_percentage
FROM monthly_growth  
ORDER BY sign_up_month 











