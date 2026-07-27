/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-511

Title:
Users Above Global Average Download

Author:
Pavlo Kotenko

Description:
Display users whose downloaded traffic
is higher than the average download
value across all users.

Topics:
- Subqueries
- AVG
- WHERE

Expected Result:

first_name
last_name
country
gb_downloaded

==========================================================
*/

SELECT
sc.first_name,
sc.last_name,
sc.country,
sc.gb_downloaded
FROM starlink_customers sc
WHERE sc.gb_downloaded > (
SELECT AVG(sc2.gb_downloaded)
FROM starlink_customers sc2
)