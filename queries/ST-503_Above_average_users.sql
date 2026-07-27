/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-503

Title:
Users Above Average Download

Author:
Pavlo Kotenko

Version:
1.0

Description:
Display users whose downloaded traffic
is greater than the average value across
all users.

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

WITH average_downloaded AS(
SELECT
AVG(sc.gb_downloaded ) AS average_gd_downloaded
FROM starlink_customers sc 
)
SELECT
sc.first_name,
sc.last_name,
sc.country,
sc.gb_downloaded 
FROM average_downloaded, starlink_customers sc
WHERE sc.gb_downloaded > average_gd_downloaded