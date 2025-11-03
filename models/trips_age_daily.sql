SELECT
    DATE
  , age
  , COUNT(*)   AS trips
  , SUM(price_rub) AS revenue_rub
FROM {{ ref("trips_users") }}
GROUP BY 1,
         2