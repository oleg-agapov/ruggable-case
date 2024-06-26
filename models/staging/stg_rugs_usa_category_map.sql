with source as (

    select * from {{ source('public', 'rugs_usa_category_map') }}

),

renamed as (

    select
        pid as product_id,
        category_id,
        category_value,
        dw_insert_timestamp

    from source

)

select * from renamed

/*
 product_id |    category_id    |      category_value      |    dw_insert_timestamp     |
------------|-------------------+--------------------------+----------------------------+
 200TAJT03  | 11265             | Maui                     | 2022-01-13 19:33:41.514826 |
 200TAJT03  | 12199             | Solid & Striped          | 2022-01-13 19:33:41.514826 |
 200TAJT03  | 12327             | Serendipity              | 2022-01-13 19:33:41.514826 |
 200TAJT03  | 17951             | Casuals                  | 2022-01-13 19:33:41.514826 |
 200TAJT03  | 7001              | Casuals                  | 2022-01-13 19:33:41.514826 |
 200TAJT03  | RUGSUSA_PROMO_GRP | All Rugs USA Promo Group | 2022-01-13 19:33:41.514826 |
 200TAJT03  | BEST_SELLERS      | Best Sellers             | 2022-01-13 19:33:41.514826 |
 200TAJT03  | 11350             | Natural Fibers           | 2022-01-13 19:33:41.514826 |
 200TAJT03  | 7017              | Solid & Striped          | 2022-01-13 19:33:41.514826 |
 200TAJT03  | Farmhouse         | Farmhouse                | 2022-01-13 19:33:41.514826 |
*/
