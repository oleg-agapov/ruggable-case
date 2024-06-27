select
    surrogate_key,
    product_id,
    color_id,
    color_value,
    dw_insert_timestamp
from {{ ref('stg_rugs_usa_color_map') }}
