WITH
    date_age_cte AS (SELECT
                         date(t.started_at)                                                AS date
                       , EXTRACT(YEAR FROM t.started_at) - EXTRACT(YEAR FROM u.birth_date) AS age
                       , price_rub
                     FROM {{ ref("trips_prep") }} AS t
                              INNER JOIN {{ source("scooters_raw","users") }} AS u ON t.user_id = u.id)
SELECT
    DATE
  , age
  , COUNT(*)   AS trips
  , SUM(price_rub) AS revenue_rub
FROM date_age_cte
GROUP BY 1,
         2