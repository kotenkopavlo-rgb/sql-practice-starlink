/*
==========================================================
Project: SQL Practice – Starlink Analytics
Task: ST-556

Title:
Subscription Status Analysis by Country

Author:
Pavlo Kotenko

Version:
1.0

Description:

The business team wants to understand the current
subscription status of customers in each country.

For each country calculate:

1. Total number of subscriptions.
2. Number of active subscriptions.
3. Number of cancelled subscriptions.
4. Number of paused subscriptions.
5. Percentage of active subscriptions.
6. Percentage of cancelled subscriptions.
7. Percentage of paused subscriptions.
8. The dominant subscription status in the country.

The dominant status should be determined by the number
of subscriptions.

If two or more statuses have the same number of
subscriptions, return 'Equal'.

Display:

- country
- total_subscriptions
- active_subscriptions
- cancelled_subscriptions
- paused_subscriptions
- active_percentage
- cancelled_percentage
- paused_percentage
- dominant_status

Requirements:

- Use starlink_customers and subscriptions.
- Join customers with subscriptions using:
  starlink_customers.unique_id = subscriptions.customer_id.
- Use conditional aggregation to count subscriptions
  by status.
- Calculate percentages relative to the total number
  of subscriptions in each country.
- Avoid integer division.
- Round percentages to 2 decimal places.
- Use CASE to determine dominant_status.
- If active_subscriptions is greater than both
  cancelled_subscriptions and paused_subscriptions,
  return 'Active'.
- If cancelled_subscriptions is greater than both
  active_subscriptions and paused_subscriptions,
  return 'Cancelled'.
- If paused_subscriptions is greater than both
  active_subscriptions and cancelled_subscriptions,
  return 'Paused'.
- Otherwise return 'Equal'.
- Sort the final result by active_percentage DESC.

Topics:

- CTE
- JOIN
- GROUP BY
- COUNT
- Conditional aggregation
- CASE WHEN
- Calculated fields
- Percentage
- Integer division
- ROUND
- ORDER BY

==========================================================
*/

WITH subscription_definition AS (
SELECT
sc.country,
COUNT(*) AS total_subscriptions,
COUNT(CASE WHEN s.status = 'Active' THEN 1 END) AS active_subscriptions,
COUNT(CASE WHEN s.status = 'Cancelled' THEN 1 END) AS cancelled_subscriptions,
COUNT(CASE WHEN s.status = 'Paused' THEN 1 END) AS paused_subscriptions
FROM starlink_customers sc 
JOIN subscriptions s 
ON sc.unique_id = s.customer_id 
GROUP BY sc.country
)
SELECT
country,
total_subscriptions, 
active_subscriptions,
cancelled_subscriptions,
paused_subscriptions,
ROUND((active_subscriptions * 1.0 / total_subscriptions) * 100.0, 2) AS active_percentage,
ROUND((cancelled_subscriptions  * 1.0 / total_subscriptions) * 100.0, 2) AS cancelled_percentage,
ROUND((paused_subscriptions  * 1.0 / total_subscriptions) * 100.0, 2) AS paused_percentage,
CASE 
	WHEN active_subscriptions > cancelled_subscriptions AND active_subscriptions > paused_subscriptions THEN 'Active'
	WHEN cancelled_subscriptions > active_subscriptions AND cancelled_subscriptions > paused_subscriptions THEN 'Cancelled'
	WHEN paused_subscriptions  > active_subscriptions  AND paused_subscriptions  > cancelled_subscriptions THEN 'Paused'
	ELSE 'Equal'
END AS dominant_status
FROM subscription_definition 
ORDER BY active_percentage DESC



































