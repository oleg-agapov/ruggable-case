-- TODO
--- availability in stock
--- searches
--- available pods
--- available colors


select
    product_id,
    product_type_id,
    product_name,
    product_url,
    origin,
    thickness,
    material,
    weave,
    weave_feature,
    color,
    brand,
    image_name,
    image_type,
    internal_name,
    category,
    min_price,
    max_price,
    availability,
    aggregate,
    clearance,
    long_description,
    shop_by_room,
    dw_insert_timestamp
from {{ ref('stg_rugs_usa_parent') }}
