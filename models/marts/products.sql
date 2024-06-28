with

products as (
    select * from {{ ref('stg_rugs_usa_parent') }}
),

product_searches as (
    select
        product_url,
        count(1) as product_searched_times
    from {{ ref('int_product_searches') }}
    group by 1
),

product_variants as (
    select
        product_id,
        count(case when status = 'In_stock' then variant end) as variants_in_stock,
        count(case when status = 'Out_of_stock' then variant end) as variants_out_of_stock,
        count(case when status = 'Back_ordered' then variant end) as variants_back_ordered
    from {{ ref('stg_rugs_usa_variant') }}
    group by 1
),


product_colors as (
    select
        product_id,
        count(1) as available_colors
    from {{ ref('stg_rugs_usa_color_map') }}
    group by 1
)

select
    p.surrogate_key,
    p.product_id,
    p.product_type_id,
    p.product_name,
    p.product_url,
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
    p.shop_by_room,
    p.dw_insert_timestamp,
    ps.product_searched_times,
    pv.variants_in_stock,
    pv.variants_out_of_stock,
    pv.variants_back_ordered,
    pc.available_colors
from products as p
left join product_searches as ps
    on ps.product_url = p.product_url
left join product_variants as pv
    on pv.product_id = p.product_id
left join product_colors as pc
    on pc.product_id = p.product_id
