/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-562

Title:
Quarterly Customer Acquisition Analysis

Author:
Pavlo Kotenko

Version:
1.0

Description:

Analyze customer acquisition by quarter.

The report should show how many new customers joined
Starlink in each quarter and how customer acquisition
changed compared with the previous quarter.

Display:

- Year
- Quarter
- Number of new customers
- Percentage of total customers
- Previous quarter customers
- Difference from previous quarter
- Quarterly growth percentage

Requirements:

- Extract the year from sign_contract_date_raw.
- Determine the quarter based on the month:
    - Q1 → January–March
    - Q2 → April–June
    - Q3 → July–September
    - Q4 → October–December
- Create a combined period identifier in the format:
  YYYY-Q1, YYYY-Q2, etc.
- Count the number of new customers for each quarter.
- Calculate each quarter's percentage of the total
  customer base.
- Use LAG() to obtain the number of customers
  from the previous quarter.
- Calculate the difference between the current and
  previous quarter.
- Calculate quarterly growth percentage.
- For the first quarter, previous quarter values and
  growth percentage should be NULL.
- Avoid division by zero when calculating growth.
- Use CTEs to keep the query readable.
- Round percentage values to two decimal places.
- Do not round intermediate calculations.
- Sort the final result chronologically by year and quarter.

Topics:

- CTE
- SUBSTR()
- CASE WHEN
- GROUP BY
- LAG()
- Window functions
- Percentage calculations
- Quarter analysis
- Growth analysis
- NULL handling
- Integer division

==========================================================
*/

WITH get_year_and_quarter AS (
SELECT
sc.sign_contract_date_raw,
SUBSTR(sc.sign_contract_date_raw, 1, 4) AS sign_up_year,
CASE
    WHEN SUBSTR(sign_contract_date_raw, 6, 2) BETWEEN '01' AND '03'
        THEN 'Q1'
    WHEN SUBSTR(sign_contract_date_raw, 6, 2) BETWEEN '04' AND '06'
        THEN 'Q2'
    WHEN SUBSTR(sign_contract_date_raw, 6, 2) BETWEEN '07' AND '09'
        THEN 'Q3'
    WHEN SUBSTR(sign_contract_date_raw, 6, 2) BETWEEN '10' AND '12'
        THEN 'Q4'
END AS quater
FROM starlink_customers sc
),
users_count_by_quarter AS (
SELECT
(sign_up_year ||'-'|| quater) AS year_quarter,
COUNT(*) AS users_count
FROM get_year_and_quarter
GROUP BY year_quarter 
),
total_amout_of_users AS (
SELECT
COUNT(*) AS total_users
FROM starlink_customers sc 
),
lag_according_to_previous_quarter AS (
SELECT *,
ROUND((users_count * 1.0 / total_users) * 100.0, 2) AS percentage_of_total_customers,
LAG (users_count ) OVER (
ORDER BY year_quarter 
) AS previous_quarter_customers 
FROM users_count_by_quarter
CROSS JOIN total_amout_of_users 
)
SELECT *,
(users_count - previous_quarter_customers) AS difference_from_previous_quarter,
FROM lag_according_to_previous_quarter  
 













