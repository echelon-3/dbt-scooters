SELECT
    COUNT(*)                                                 AS trips
  , COUNT(DISTINCT user_id)                                  AS users
  , AVG(duration_s) / 60                                     AS avg_duration_min
  , SUM(price_rub)                                           AS revenue_rub
  , COUNT(is_free or null) / CAST(COUNT(*) AS real) * 100    AS free_trips_pct
  , SUM(distance_m) /1000                                    AS sum_distance_km
FROM {{ ref("trips_prep") }}