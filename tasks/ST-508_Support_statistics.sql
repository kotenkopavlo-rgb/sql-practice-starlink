/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-508

Title:
Support Statistics

Author:
Pavlo Kotenko

Version:
1.0

Description:
Return for each country:

- total users
- support users
- tickets
- average tickets per all users
- average tickets per support users

Topics:
- LEFT JOIN
- GROUP BY
- COUNT
- DISTINCT
- ROUND

Expected Result

country
total_users
support_users
tickets
avg_tickets_all_users
avg_tickets_support_users

==========================================================
*/

WITH
country_stats AS(
SELECT 
sc.country,
COUNT(DISTINCT sc.unique_id  ) AS total_users,
COUNT(DISTINCT st.customer_id ) AS support_users,
COUNT(st.ticket_id) AS tickets,
ROUND((COUNT(st.ticket_id ))*1.0/(COUNT(DISTINCT sc.unique_id )),2) AS avg_tickets_all_users,
ROUND((COUNT(st.ticket_id ))*1.0/(COUNT(DISTINCT st.customer_id)),2) AS avg_tickets_support_users
FROM starlink_customers sc 
LEFT JOIN support_tickets st 
ON sc.unique_id = st.customer_id 
GROUP BY sc.country
)
SELECT *
FROM country_stats