WITH active_days_in_week AS (
    /* For each user, we find the trip statistics by weeks:
      days_per_week - the number of days with trips per week */
    select
        user_id,
        date_trunc('week', date) as "week",
        count(distinct date) as days_per_week
    from
        {{ ref("trips_prep") }}
    group by
        1,
        2
    )
select
    user_id,
    avg(days_per_week) >= 6 as fan,
    avg(days_per_week) >= 3 as regular
from active_days_in_week
group by
    1