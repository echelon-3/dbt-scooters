SELECT
    DATE,
    AGE,
    COUNT(*) AS TRIPS,
    SUM(PRICE_RUB) AS REVENUE_RUB
FROM {{ ref("trips_users") }}
GROUP BY
    1,
    2
