SELECT
     ec.*
    ,et.type
FROM {{ ref("events_clean") }} ec
LEFT JOIN {{ ref("event_types") }} et on ec.type_id=et.type_id