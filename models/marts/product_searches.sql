select
    base_url,
    page_links,
    card_links,
    request_time_stamp,
    dw_insert_timestamp
from {{ ref('stg_rugs_usa_links') }}
