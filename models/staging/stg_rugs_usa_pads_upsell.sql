with source as (

    select * from {{ source('public', 'rugs_usa_pads_upsell') }}

),

renamed as (

    select
        {{ dbt_utils.surrogate_key(['pad_id', 'p_id']) }} as surrogate_key,
        pad_id,
        p_id as product_id,
        variant,
        size,
        shape,
        price,
        width,
        sqft,
        type,
        stock,
        height,
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
    pad_id       |    size    |   shape   | price | width | sqft |   type   | stock | height | variant |   pid     |    dw_insert_timestamp     
-----------------+------------+-----------+-------+-------+------+----------+-------+--------+---------+-----------+----------------------------
 200JAPD1A-18034 | 2' x 4'    | Rectangle | 20.99 |     2 |    8 | standard |  1586 |      4 | 2304O   | 200TAJT03 | 2022-01-13 20:44:54.227965
 200TAJT03-2304O | 2' 3" x 4' | Oval      |  45.1 |  2.25 |    9 |          |       |      4 | 2304O   | 200TAJT03 | 2022-01-13 20:44:54.227965
 200AFPD01A-204  | 2' x 4'    | Rectangle | 24.99 |     2 |    8 | premium  |   527 |      4 | 2304O   | 200TAJT03 | 2022-01-13 20:44:54.227965
 200JAPD1A-18034 | 2' x 4'    | Rectangle | 20.99 |     2 |    8 | standard |  1586 |      4 | 2304    | 200TAJT03 | 2022-01-13 20:44:54.227965
 200TAJT03-2304  | 2' 3" x 4' | Rectangle |  50.4 |  2.25 |    9 |          |       |      4 | 2304    | 200TAJT03 | 2022-01-13 20:44:54.227965
 200AFPD01A-204  | 2' x 4'    | Rectangle | 24.99 |     2 |    8 | premium  |   527 |      4 | 2304    | 200TAJT03 | 2022-01-13 20:44:54.227965
 200JAPD1A-R808  | 8'         | Round     | 58.99 |     8 |   64 | standard |    95 |      8 | R303    | 200TAJT03 | 2022-01-13 20:44:54.227965
 200TAJT03-R303  | 3'         | Round     |  55.1 |     3 |    9 |          |       |      3 | R303    | 200TAJT03 | 2022-01-13 20:44:54.227965
 200AFPD01A-R404 | 4'         | Round     | 41.99 |     4 |   16 | premium  |   210 |      4 | R303    | 200TAJT03 | 2022-01-13 20:44:54.227965
*/
