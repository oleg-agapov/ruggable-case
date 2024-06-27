with 

product_searches as (
    select *
    from {{ ref('stg_rugs_usa_links') }}
    where base_url = 'https://www.rugsusa.com/rugsusa/control/search-rugs'
),

products as (
    select *
    from {{ ref('stg_rugs_usa_parent') }}
)

select
    ps.surrogate_key,
    ps.base_url,
    ps.page_links,
    ps.card_links,
    ps.product_url,
    ps.request_time_stamp,
    ps.dw_insert_timestamp,
    p.product_id,
    p.product_type_id,
    p.product_name,
    p.origin,
    p.thickness,
    p.material,
    p.weave,
    p.weave_feature,
    p.color,
    p.brand,
    p.image_name,
    p.image_type,
    p.internal_name,
    p.category,
    p.min_price,
    p.max_price,
    p.availability,
    p.aggregate,
    p.clearance,
    p.long_description,
    p.shop_by_room
from product_searches ps
left join products p 
    on p.product_url = ps.product_url
