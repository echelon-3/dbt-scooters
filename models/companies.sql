SELECT
    company,
    COUNT(DISTINCT model) AS models,
    SUM(scooters.scooters) AS scooters
FROM {{ ref("scooters") }}
GROUP BY company
