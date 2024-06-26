with source as (

    select * from {{ source('public', 'rugs_usa_links') }}

),

renamed as (

    select
        base_url,
        page_links,
        card_links,
        request_time_stamp,
        dw_insert_timestamp

    from source

)

select * from renamed

/*
                      base_url                       |                     page_links                      |                                            card_links                                            |     request_time_stamp     |    dw_insert_timestamp     
-----------------------------------------------------+-----------------------------------------------------+--------------------------------------------------------------------------------------------------+----------------------------+----------------------------
 https://www.rugsusa.com/rugsusa/control/search-rugs | https://www.rugsusa.com/rugsusa/control/search-rugs | https://www.rugsusa.com//rugsusa/rugs/rugs-usa-jute-braided/Natural/200TAJT03-P.html             | 2021-12-14 14:25:24.397133 | 2022-01-13 19:33:41.512911
 https://www.rugsusa.com/rugsusa/control/search-rugs | https://www.rugsusa.com/rugsusa/control/search-rugs | https://www.rugsusa.com//rugsusa/rugs/rugs-usa-veronica-wool-braided/Off-White/200CB01-P.html    | 2021-12-14 14:25:09.360638 | 2022-01-13 19:33:41.512911
 https://www.rugsusa.com/rugsusa/control/search-rugs | https://www.rugsusa.com/rugsusa/control/search-rugs | https://www.rugsusa.com//rugsusa/rugs/rugs-usa-handwoven-chaste/Natural/200HMMT01A-P.html        | 2021-12-14 14:25:12.290571 | 2022-01-13 19:33:41.512911
*/
