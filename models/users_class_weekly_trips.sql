WITH active_days_in_week AS (
    /* For each user, we find the trip statistics by weeks:
      days_per_week - the number of days with trips per week */
    SELECT
        user_id,
        date_trunc('week', date) AS week,
        count(DISTINCT date) AS days_per_week
    FROM
        {{ ref("trips_prep") }}
    GROUP BY
        1,
        2
)

SELECT
    user_id,
    avg(days_per_week) >= 6 AS fan,
    avg(days_per_week) >= 3 AS regular
FROM active_days_in_week
GROUP BY
    1
