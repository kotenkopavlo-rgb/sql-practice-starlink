/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-513

Title:
Users Without Support Tickets

Author:
Pavlo Kotenko

Version:
1.0

Description:
Display users who have never created
a support ticket.

Topics:
- NOT EXISTS
- Correlated Subqueries

Expected Result:

first_name
last_name
country

==========================================================
*/

SELECT
sc.first_name,
sc.last_name,
sc.country 
FROM starlink_customers sc
WHERE NOT EXISTS (
SELECT 1 
FROM support_tickets st 
WHERE sc.unique_id = st.customer_id 
)
