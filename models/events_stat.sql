SELECT
    COUNT(type = 'cancel_search' OR NULL)
    / COUNT(type = 'start_search' OR NULL)::float4
    * 100 AS cancel_pct
FROM {{ ref("events_full") }}
