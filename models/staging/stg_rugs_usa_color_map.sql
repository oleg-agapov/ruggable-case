with source as (

    select * from {{ source('public', 'rugs_usa_color_map') }}

),

renamed as (

    select
        pid as product_id,
        color_id,
        color_value,
        dw_insert_timestamp

    from source

)

select * from renamed

/*
 product_id |   color_id  | color_value |    dw_insert_timestamp     |
------------|-------------+-------------+----------------------------+
  200TAJT03 | 200TAJT03   | Natural     | 2022-01-13 19:33:41.514414 |
  200TAJT03 | 200TAJT03B  | Off White   | 2022-01-13 19:33:41.514414 |
  200TAJT03 | 200TAJT03C  | Black       | 2022-01-13 19:33:41.514414 |
  200TAJT03 | 200TAJT03D  | Navy        | 2022-01-13 19:33:41.514414 |
  200CB01   | 200CB01     | Off White   | 2022-01-13 19:33:41.514414 |
  200CB01   | 200CB01C    | Navy        | 2022-01-13 19:33:41.514414 |
  200CB01   | 200CB01D    | Light Gray  | 2022-01-13 19:33:41.514414 |
  200CB01   | 200CB01E    | Blue        | 2022-01-13 19:33:41.514414 |
  200CB01   | 200CB01F    | Silver      | 2022-01-13 19:33:41.514414 |
  200CB01   | 200CB01G    | Light Blue  | 2022-01-13 19:33:41.514414 |
*/
