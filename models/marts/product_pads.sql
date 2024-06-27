select
    surrogate_key,
    pad_id,
    product_id
    variant,
    size,
    shape,
    price,
    width,
    sqft,
    type,
    stock,
    height,
    dw_insert_timestamp
from {{ ref('stg_rugs_usa_pads_upsell') }}
