with source as (

    select * from {{ source('public', 'rugs_usa_color_map') }}

),

renamed as (

    select
        {{ dbt_utils.surrogate_key(['color_id']) }} as surrogate_key,
        pid as product_id,
        color_id,
        color_value,
        dw_insert_timestamp

    from source

),

deduplicated as (
    select *,
        row_number() over (partition by surrogate_key order by dw_insert_timestamp desc) as rn
    from renamed
)

select * 
from deduplicated
where rn = 1


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
