select
     tp.*
    ,u.sex
    ,EXTRACT(YEAR FROM tp.started_at) - EXTRACT(YEAR FROM u.birth_date) AS age
    ,{{ updated_at() }}
from {{ ref("trips_prep") }} tp
left join {{ source("scooters_raw", "users") }} u on tp.user_id = u.id
{% if is_incremental() %}
    where
        tp.id > (select max(id) from {{ this }})
    order by
        id
    limit
        75000
{% else %}
    where
        tp.id <= 75000
{% endif %}