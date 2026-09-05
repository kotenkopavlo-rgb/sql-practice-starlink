/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-551

Title:
Customer Email Domains

Author:
Pavlo Kotenko

Version:
1.0

Description:

Determine which email domains are the most popular among
Starlink customers.

Extract the domain from the customer's email address.
The domain is the part of the email after the '@' symbol.

Example:

john.smith@gmail.com → gmail.com
anna@yahoo.com       → yahoo.com

For each email domain calculate:

- email_domain
- domain_label
- users_count
- percentage_of_users

Domain metrics:

- email_domain — email domain extracted from the customer's
  email address
- domain_label — descriptive label based on the email domain
- users_count — number of customers using the domain
- percentage_of_users — percentage of all customers using
  the domain

Create domain_label using the following rules:

- gmail.com → Gmail users
- yahoo.com → Yahoo users
- outlook.com → Outlook users
- all other domains → Other users

The domain should be extracted directly from the email
field using string functions.

Calculate percentage_of_users as:

users_count / total_users * 100

Use the total number of customers in the dataset as the
denominator.

Do not use the subscriptions table for this task.

Round percentage_of_users to 2 decimal places.

Sort the final result by users_count in descending order.

Display:

- email_domain
- domain_label
- users_count
- percentage_of_users

Topics:

- CTE
- String functions
- SUBSTR
- INSTR
- CASE
- String concatenation (||)
- COUNT
- GROUP BY
- CROSS JOIN
- Calculated fields
- Percentage calculation
- ROUND
- ORDER BY
==========================================================
*/

WITH getting_email_domain AS (
SELECT 
SUBSTR(sc.email, INSTR(sc.email, '@') + 1) AS email_domain,
COUNT(*) AS users_count
FROM starlink_customers sc 
GROUP BY email_domain 
),
adding_domain_label AS (
SELECT
email_domain,
CASE 
		WHEN email_domain = 'gmail.com' THEN 'Gmail users'
		WHEN email_domain = 'hotmail.com' THEN 'Hotmail users'
		WHEN email_domain = 'icloud.com' THEN 'Icloud users'
		WHEN email_domain = 'outlook.com' THEN 'Outlook users'
		WHEN email_domain = 'proton.me' THEN 'Proton users'
		WHEN email_domain = 'yahoo.com' THEN 'Yahoo users'
		WHEN email_domain = 'zoho.com' THEN 'Zoho users'
		ELSE 'Other users'
	END AS domain_label,
users_count
FROM getting_email_domain 
),
total_amount_of_users AS (
SELECT
SUM(users_count) AS total_users
FROM adding_domain_label 
)
SELECT
email_domain,
domain_label,
users_count,
total_users,
ROUND((users_count * 1.0 / total_users) * 100.0,2) AS percentage_of_users
FROM adding_domain_label 
CROSS JOIN total_amount_of_users 
















