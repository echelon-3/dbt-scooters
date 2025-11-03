SELECT
    date
  , SUM(price_rub) AS revenue_rub
  , NOW() at time zone 'utc' as updated_at
FROM {{ ref("trips_prep") }}

{% if is_incremental() %}
    WHERE date >= (SELECT MAX(date) - INTERVAL '2 days' FROM {{ this }} )
{% endif %}

GROUP BY date