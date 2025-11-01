WITH date_age_cte AS (SELECT
                          date(t.started_at)                                                AS date
                        , EXTRACT(YEAR FROM t.started_at) - EXTRACT(YEAR FROM u.birth_date) AS age
                      FROM scooters_raw.trips AS t
                               INNER JOIN scooters_raw.users AS u ON t.user_id = u.id),
     count_cte AS (SELECT
                       date
                     , age
                     , COUNT(*) AS trips
                   FROM date_age_cte
                   GROUP BY 1,
                            2)
SELECT
    age
  , AVG(trips) AS avg_trips
FROM count_cte
GROUP BY 1
ORDER BY 1