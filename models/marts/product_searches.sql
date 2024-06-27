-- TODO
--- add product info

select
    surrogate_key,
    base_url,
    page_links,
    card_links,
    product_url,
    request_time_stamp,
    dw_insert_timestamp
from {{ ref('stg_rugs_usa_links') }}
where base_url = 'https://www.rugsusa.com/rugsusa/control/search-rugs'
