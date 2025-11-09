SELECT
    ec.user_id,
    ec.type_id,
    et.type,
    ec.timestamp,
    ec.updated_at
FROM {{ ref("events_clean") }} AS ec
LEFT JOIN {{ ref("event_types") }} AS et ON ec.type_id = et.type_id
