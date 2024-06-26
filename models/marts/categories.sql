select
    product_id,
    category_id,
    category_value,
    dw_insert_timestamp
from {{ ref('stg_rugs_usa_category_map') }}
