{% set date = var("date", none) %}

SELECT DISTINCT
    user_id,
    timestamp,
    type_id
    , {{ updated_at() }}
FROM {{ source("scooters_raw","events") }}
WHERE
    {% if is_incremental() %}
        {% if date %}
        date(timestamp) = date('{{ date }}')
    {% else %}
            timestamp > (SELECT max(timestamp) FROM {{ this }})
        {% endif %}
    {% else %}
    date(timestamp) < date('2023-08-01')
{% endif %}
