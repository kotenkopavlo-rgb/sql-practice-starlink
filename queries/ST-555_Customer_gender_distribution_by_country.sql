/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-555

Title:
Customer Gender Distribution by Country

Author:
Pavlo Kotenko

Version:
1.0

Description:

The business team wants to understand the gender
distribution of customers across different countries.

For each country calculate:

1. Total number of customers.
2. Number of male customers.
3. Number of female customers.
4. Percentage of male customers.
5. Percentage of female customers.
6. Which gender represents the majority of customers.

The majority gender should be determined based on the
number of customers.

If the number of male and female customers is equal,
the majority should be classified as 'Equal'.

Display:

- country
- total_users
- male_users
- female_users
- male_percentage
- female_percentage
- majority_gender

Requirements:

- Use only the starlink_customers table.
- Use conditional aggregation to count male and female
  customers.
- Calculate both gender percentages relative to the
  total number of customers in the country.
- Avoid integer division.
- Round percentages to 2 decimal places.
- Use CASE to determine majority_gender.
- If male_users > female_users, return 'Male'.
- If female_users > male_users, return 'Female'.
- If male_users = female_users, return 'Equal'.
- Sort the final result by country ASC.

Topics:

- CTE
- GROUP BY
- COUNT
- Conditional aggregation
- CASE WHEN
- Calculated fields
- Percentage
- Integer division
- ROUND
- ORDER BY

==========================================================
*/

WITH statistic_by_gender AS (
SELECT
country,
COUNT(*) AS total_users,
COUNT(CASE WHEN sex = 'Male' THEN 1 END) AS male_users,
COUNT(CASE WHEN sex = 'Female' THEN 1 END) AS female_users
FROM starlink_customers sc 
GROUP BY sc.country 
)
SELECT 
country,
total_users,
male_users,
female_users,
ROUND((male_users * 1.0 / total_users) * 100.0, 2) AS male_percentage,
ROUND((female_users * 1.0 / total_users) * 100.0, 2) AS female_percentage,
CASE 
	WHEN male_users > female_users THEN 'Male'
	WHEN male_users < female_users THEN 'Female'
	ELSE 'Equal'
END AS majority_gender
FROM statistic_by_gender  
ORDER BY country ASC




















