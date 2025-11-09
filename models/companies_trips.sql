SELECT
    c.company,
    COUNT(*) AS trips,
    MAX(c.scooters) AS scooters,
    COUNT(*)::float4 / MAX(c.scooters) AS trips_per_scooter
FROM {{ ref("trips_prep") }} tp
LEFT JOIN {{ ref("scooters") }} s ON tp.scooter_hw_id = s.hardware_id
LEFT JOIN {{ ref("companies") }} c ON s.company = c.company
GROUP BY c.company
