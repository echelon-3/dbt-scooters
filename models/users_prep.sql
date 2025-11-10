SELECT
    id,
    birth_date,
    COALESCE(sru.sex, uns.sex) AS sex
FROM {{ source('scooters_raw','users') }} AS sru
LEFT JOIN {{ ref("users_name_sex") }} AS uns
    ON sru.first_name = uns.name
