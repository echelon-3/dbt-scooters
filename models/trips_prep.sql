SELECT
    id
  , user_id
  , scooter_hw_id
  , started_at
  , finished_at
  , start_lat
  , start_lon
  , finish_lat
  , finish_lon
  , distance                                     AS distance_m
  , (price / 100)::decimal(20, 2)                AS price_rub
  , EXTRACT(EPOCH FROM finished_at - started_at) AS duration_s
  , started_at != finished_at AND price = 0      AS is_free
  , date(started_at)                             AS date
FROM {{ source('scooters_raw', 'trips') }}