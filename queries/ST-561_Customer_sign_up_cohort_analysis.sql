/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-561

Title:
Customer Sign-up Cohort Analysis

Author:
Pavlo Kotenko

Version:
1.0

Description:

Analyze customer distribution by sign-up cohort.

A cohort represents the month in which a customer first
signed a contract with Starlink.

The goal is to determine how many customers joined in each
cohort and what percentage of the total customer base each
cohort represents.

Display:

- Sign-up cohort month
- Number of customers in the cohort
- Percentage of total customers
- Cumulative number of customers
- Cumulative percentage of total customers

Requirements:

- Extract the sign-up month in YYYY-MM format.
- Group customers by their sign-up month.
- Calculate the number of customers in each cohort.
- Calculate the percentage of total customers represented
  by each cohort.
- Calculate the cumulative number of customers by cohort.
- Calculate the cumulative percentage of total customers.
- Use a CTE to calculate the total number of customers.
- Use CROSS JOIN to make the total customer count available
  for percentage calculations.
- Use a window function to calculate cumulative values.
- Round percentage values to two decimal places.
- Do not round intermediate calculations.
- Sort the final result by sign-up cohort month
  in ascending order.

Topics:

- CTE
- SUBSTR()
- GROUP BY
- CROSS JOIN
- COUNT()
- Window functions
- SUM() OVER()
- Percentage calculations
- Cumulative metrics
- Cohort analysis
- Rounding

==========================================================
*/

WITH sort_and_calculate_users_by_month AS (
SELECT
SUBSTR(sc.sign_contract_date_raw, 1, 7) AS sign_up_cohort_month,
COUNT(*) AS users_count
FROM starlink_customers sc 
GROUP BY sign_up_cohort_month
),
total_amount_of_users AS (
SELECT
COUNT(*) AS total_users
FROM starlink_customers sc 
),
cumulative_months AS (
SELECT *,
SUM(users_count ) OVER (
ORDER BY sign_up_cohort_month 
) AS cumulative_users
FROM sort_and_calculate_users_by_month
CROSS JOIN total_amount_of_users 
)
SELECT
sign_up_cohort_month,
users_count AS number_of_customers_in_the_cohort,
ROUND(((users_count * 1.0 / total_users) * 100.0),2) AS percentage_of_total_customers, 
cumulative_users AS cumulative_number_of_customers,
ROUND(((cumulative_users * 1.0 / total_users) * 100.0),2) AS cumulative_percentage_of_total_customers
FROM cumulative_months  
ORDER BY sign_up_cohort_month ASC 
















