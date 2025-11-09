SELECT
    "group" AS age_group,
    COUNT(*) AS trips,
    SUM(price_rub) AS revenue_rub
FROM {{ ref("trips_users") }} tu
LEFT JOIN
    {{ ref("age_groups") }} ag
    ON tu.age BETWEEN ag.age_start AND ag.age_end
GROUP BY "group"
