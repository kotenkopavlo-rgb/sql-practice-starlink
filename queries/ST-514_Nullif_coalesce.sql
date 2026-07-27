/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-514

Title:
Prevent Division by Zero

Author:
Pavlo Kotenko

Version:
1.0

Description:
Improve support statistics by handling
division by zero with NULLIF() and
replacing NULL values using COALESCE().

Topics:
- NULLIF
- COALESCE
- Aggregate Functions

Expected Result:

country
total_users
support_users
tickets
avg_tickets_all_users
avg_tickets_support_users

==========================================================
*/

WITH country_stats AS (
SELECT
    sc.country,
    COUNT(DISTINCT sc.unique_id) AS total_users,
    COUNT(DISTINCT st.customer_id) AS support_users,
    COUNT(st.ticket_id) AS tickets,
    COALESCE (ROUND(COUNT(st.ticket_id) * 1.0 /(NULLIF(COUNT(DISTINCT sc.unique_id), 0)),2),0) AS avg_all_users,
    COALESCE (ROUND(COUNT(st.ticket_id) * 1.0 /(NULLIF(COUNT(DISTINCT st.customer_id), 0)),2),0) AS avg_support_users
FROM starlink_customers sc
LEFT JOIN support_tickets st
ON sc.unique_id = st.customer_id
GROUP BY sc.country
)
SELECT *
FROM country_stats;