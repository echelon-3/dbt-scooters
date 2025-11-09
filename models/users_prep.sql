SELECT
    id,
    sex,
    birth_date
FROM {{ source('scooters_raw','users') }}
