/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-552

Title:
Customer Country & Phone Validation

Author:
Pavlo Kotenko

Version:
1.0

Description:

Validate whether the country stored in the customer profile
can be confirmed using the customer's phone number.

Create a phone_country field based on the phone number.

Only phone number patterns that allow the country to be
determined reliably should be assigned to a specific country.

If the phone number does not contain enough information to
determine the country uniquely, classify it as 'Unknown'.

Some countries may share the same country calling code.
For such cases, additional digits may be used to determine
the country. If the country still cannot be determined
reliably, use 'Unknown'.

After determining phone_country, compare it with the country
stored in the customer profile.

Create validation_status:

- Match — country = phone_country
- Mismatch — country <> phone_country
- Unknown — phone_country = 'Unknown'

Unknown users must not be counted as mismatched users.

For each country calculate:

- country
- users_count
- matched_users
- mismatched_users
- unknown_users
- match_percentage
- mismatch_percentage

Metrics:

- country — country stored in the customer profile
- users_count — total number of customers from the country
- matched_users — customers whose profile country matches
  phone_country
- mismatched_users — customers whose profile country differs
  from phone_country
- unknown_users — customers whose phone country cannot be
  determined reliably
- match_percentage — percentage of matched customers among
  all customers from the country
- mismatch_percentage — percentage of mismatched customers
  among all customers from the country

Calculate percentages as:

matched_users / users_count * 100

mismatched_users / users_count * 100

Avoid integer division when calculating percentages.

Round percentage values to 2 decimal places.

Sort the final result by mismatch_percentage in descending
order.

Use only the starlink_customers table.

Display:

- country
- users_count
- matched_users
- mismatched_users
- unknown_users
- match_percentage
- mismatch_percentage

Topics:

- CTE
- CASE
- String functions
- SUBSTR
- LIKE
- COUNT
- GROUP BY
- Conditional aggregation
- Calculated fields
- Data validation
- Data quality analysis
- Percentage calculation
- Integer division
- ROUND
- ORDER BY
==========================================================
*/

WITH phone_country_calculation AS (
SELECT
country,
phone_number,
CASE
WHEN phone_number LIKE '+380%' THEN 'Ukraine'
WHEN phone_number LIKE '+44%' THEN 'United Kingdom'
WHEN phone_number LIKE '+33%' THEN 'France'
WHEN phone_number LIKE '+34%' THEN 'Spain'
WHEN phone_number LIKE '+55%' THEN 'Brazil'
WHEN phone_number LIKE '+49%' THEN 'Germany'
WHEN phone_number LIKE '+81%' THEN 'Japan'
WHEN phone_number LIKE '+61%' THEN 'Australia'
WHEN phone_number LIKE '+1%' THEN 'Unknown'
ELSE 'Unknown'
END AS phone_country
FROM starlink_customers
),
validation_status_calculation AS (
SELECT *,
CASE
WHEN phone_country = 'Unknown' THEN 'Unknown'
WHEN phone_country = country THEN 'Match'
ELSE 'Mismatch'
END AS validation_status
FROM phone_country_calculation
),
country_validation_statistic AS (
SELECT
country,
COUNT(*) AS users_count,
COUNT(
CASE
WHEN validation_status = 'Match' THEN 1
END
) AS matched_users,
COUNT(
CASE
WHEN validation_status = 'Mismatch' THEN 1
END
) AS mismatched_users,
COUNT(
CASE
WHEN validation_status = 'Unknown' THEN 1
END
) AS unknown_users
FROM validation_status_calculation
GROUP BY country
)
SELECT 
country,
users_count,
matched_users,
mismatched_users,
unknown_users,
ROUND(((matched_users * 1.0 / users_count) * 100.0) ,2) AS match_percentage,
ROUND(((mismatched_users * 1.0 / users_count) * 100.0) ,2) AS mismatch_percentage
FROM country_validation_statistic
ORDER BY mismatch_percentage DESC















