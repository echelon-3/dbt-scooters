select
    tp.*,
    u.sex,
    EXTRACT(year from tp.started_at) - EXTRACT(year from u.birth_date) as age
    ,{{ updated_at() }}
from {{ ref("trips_prep") }} as tp
left join {{ source("scooters_raw", "users") }} as u on tp.user_id = u.id
{% if is_incremental() %}
    where
        tp.id > (select MAX(id) from {{ this }})
    order by
        id
    limit
        75000
{% else %}
    where
        tp.id <= 75000
{% endif %}
