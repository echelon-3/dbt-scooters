SELECT
    date(started_at)     AS date
  , COUNT(*)             AS trips
  , MAX(price) / 100     AS max_price_rub
  , AVG(distance) / 1000 AS avg_distance_km
FROM scooters_raw.trips
GROUP BY date(started_at)