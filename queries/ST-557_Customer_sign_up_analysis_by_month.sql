/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-557

Title:
Customer Sign-up Analysis by Month

Author:
Pavlo Kotenko

Version:
1.0

Description:

The business team wants to understand how customer
registrations are distributed across months.

Analyze the customer contract signing dates and calculate
the number and percentage of customers who signed their
contracts in each month.

For each month calculate:

1. Number of customers who signed a contract.
2. Percentage of all customers represented by that month.
3. Cumulative number of customers up to that month.

Display:

- sign_up_month
- users_count
- users_percentage
- cumulative_users

Requirements:

- Use only the starlink_customers table.
- Use sign_contract_date_raw as the source date.
- Extract the month in YYYY-MM format.
- Group customers by sign-up month.
- Calculate the percentage of all customers represented
  by each month.
- Avoid integer division.
- Round users_percentage to 2 decimal places.
- Calculate cumulative_users using a window function.
- Sort the result chronologically by sign_up_month.
- The cumulative value must increase according to the
  chronological order of the months.

Topics:

- CTE
- String functions
- Date extraction
- SUBSTR
- COUNT
- GROUP BY
- Window Functions
- SUM() OVER()
- ORDER BY
- Calculated fields
- Percentage
- Integer division
- ROUND
- Cumulative total

==========================================================
*/ 

WITH calculate_users_by_month AS (
SELECT
SUBSTR(sign_contract_date_raw, 1, 7) AS sign_up_month,
COUNT(*) AS users_count
FROM starlink_customers sc 
GROUP BY sign_up_month
),
total_amount_of_users AS (
SELECT
COUNT(*) AS total_amount_users
FROM starlink_customers sc 
)
SELECT
sign_up_month,
users_count,
ROUND((users_count * 1.0 / total_amount_users) * 100.0 ,2) AS users_percentage,
SUM(users_count) OVER (
    ORDER BY sign_up_month
) AS cumulative_users
FROM calculate_users_by_month   
CROSS JOIN total_amount_of_users 
ORDER BY sign_up_month 





