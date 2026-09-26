/*
Project: SQL Practice – Starlink Analytics
Task: ST-566
Title: Customer Data Usage Segmentation
Author: Pavlo Kotenko
Version: 1.0

Description:
Analyze customer data usage and classify customers into usage segments.

Display:
- Customer ID
- Customer full name
- Country
- Downloaded GB
- Uploaded GB
- Total data usage
- Upload percentage
- Usage segment

Usage segment rules:
- Light User — total usage < 100 GB
- Regular User — total usage >= 100 and < 500 GB
- Power User — total usage >= 500 and < 1000 GB
- Extreme User — total usage >= 1000 GB

Requirements:
- Use starlink_customers table.
- Combine first and last name into full name.
- Calculate total data usage:
  gb_downloaded + gb_uploaded
- Calculate upload percentage:
  gb_uploaded / total usage * 100
- Use CASE for usage segmentation.
- Round calculated percentages to two decimals.
- Sort customers by total data usage descending.

Topics:
CASE
Arithmetic calculations
String concatenation
Aliases
CTE
NULL handling
Rounding
ORDER BY
*/

WITH users_statistic AS (
SELECT
sc.unique_id AS customer_id,
(sc.first_name || " " || sc.last_name) AS full_name,
sc.country,
sc.gb_downloaded,
sc.gb_uploaded,
(sc.gb_downloaded + sc.gb_uploaded) AS total_data_usage,
ROUND((sc.gb_uploaded  / (sc.gb_downloaded   + sc.gb_uploaded) * 100.0),2) AS upload_percentage,
CASE 
WHEN (sc.gb_downloaded + sc.gb_uploaded) >= 1000 THEN "Extreme user"
WHEN (sc.gb_downloaded + sc.gb_uploaded) >= 500 THEN "Power user"
WHEN (sc.gb_downloaded + sc.gb_uploaded) >= 100 THEN "Regular user"
ELSE "Light user"
END AS usage_segment
FROM starlink_customers sc 
)
SELECT *
FROM users_statistic
ORDER BY total_data_usage DESC





