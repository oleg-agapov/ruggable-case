select *
from {{ ref('stg_rugs_usa_links') }}
where base_url = 'https://www.rugsusa.com/rugsusa/control/search-rugs'
