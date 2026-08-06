/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-523

Title:
Users Above Global Average Download

Author:
Pavlo Kotenko

Version:
1.0

Description:

Display all users whose downloaded traffic
is ABOVE the global average downloaded traffic.

Display:

- first_name
- last_name
- country
- gb_downloaded
- global_average_download

Topics:

- CTE
- Aggregate Functions
- CROSS JOIN (or JOIN to one-row CTE)
- AVG()

Expected Result:

first_name
last_name
country
gb_downloaded
global_average_download

==========================================================
*/

WITH user_information AS (
SELECT 
sc.first_name,
sc.last_name,
sc.country,
sc.gb_downloaded 
FROM starlink_customers sc
),
global_average_download AS(
SELECT
AVG(sc.gb_downloaded) AS global_average_download
FROM starlink_customers sc 
)
SELECT
first_name,
last_name,
country,
gb_downloaded,
ROUND(global_average_download,2) AS global_average_download
FROM user_information
CROSS JOIN global_average_download 
WHERE gb_downloaded > global_average_download 








