SELECT DISTINCT
    user_id
  , timestamp
  , type_id
  , {{ updated_at() }}
FROM {{ source("scooters_raw","events") }}
{% if is_incremental() %}
    WHERE timestamp > (select max(timestamp) from {{ this }})
{% else %}
    WHERE date(timestamp) < date('2023-08-01')
{% endif %}