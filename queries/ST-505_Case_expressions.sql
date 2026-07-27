/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-505

Title:
User Categories

Author:
Pavlo Kotenko

Version:
1.0

Description:
Assign every user to one of the
download categories:

- Beginner
- Regular
- Advanced
- Expert

Topics:
- CASE
- Conditional Logic

Expected Result:

first_name
last_name
country
gb_downloaded
user_category

==========================================================
*/

SELECT
COUNT(*) AS amount_of_users,
CASE
	WHEN gb_downloaded < 500 THEN 'Beginner'
	WHEN gb_downloaded < 1501 THEN 'Regular'
	WHEN gb_downloaded < 2501 THEN 'Advanced'
	ELSE 'Expert'
END AS 'User_category'
FROM starlink_customers
GROUP BY User_category 

