with source as (

    select * from {{ source('public', 'rugs_usa_variant') }}

),

renamed as (

    select
        {{ dbt_utils.surrogate_key(['variant', 'pid']) }} as surrogate_key,
        variant as variant,
        pid as product_id,
        actual_size,
        weave_feature,
        weave_cat,
        size_grp,
        shipping_size,
        shape,
        weight,
        price,
        msrp,
        stock_level,
        depletion_level,
        low_stock,
        estimated_delivery_date,
        this_isd_range,
        status,
        origin,
        new_arrival,
        "stockMsg" as stock_msg,
        "stockEddMsg" as stock_edd_msg,
        other_stock_core,
        other_stock_compass,
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
    pid    | variant |   actual_size    | weave_feature | weave_cat | size_grp |  shipping_size   |   shape   | weight | price | msrp  | stock_level | depletion_level | low_stock | estimated_delivery_date | this_isd_range |  status  | origin | new_arrival | stock_msg | stock_edd_msg | other_stock_core | other_stock_compass |    dw_insert_timestamp     
-----------+---------+------------------+---------------+-----------+----------+------------------+-----------+--------+-------+-------+-------------+-----------------+-----------+-------------------------+----------------+----------+--------+-------------+-----------+---------------+------------------+---------------------+----------------------------
 200TAJT03 | 2304O   | 2_ft 3_in x 4_ft |               | Braided   | 2x3      | W 6 x L 28 x H 6 | Oval      |      5 |  45.1 | 100.3 |         279 |             168 | f         | NA                      | NA             | In_stock |        | N           | NA        | NA            |                0 |                   0 | 2022-01-13 19:33:41.513970
 200TAJT03 | 2304    | 2_ft 3_in x 4_ft |               | Braided   | 2x3      | W 5 x L 28 x H 5 | Rectangle |      6 |  50.4 |   112 |        1299 |             140 | f         | NA                      | NA             | In_stock |        | N           | NA        | NA            |                0 |                   0 | 2022-01-13 19:33:41.513970
 200TAJT03 | R303    | 3_ft             |               | Braided   | 2x3      | W 4 x L 37 x H 4 | Round     |      4 |  55.1 | 122.5 |         509 |              42 | f         | NA                      | NA             | In_stock |        | N           | NA        | NA            |                0 |                   0 | 2022-01-13 19:33:41.513970
 200TAJT03 | 305O    | 3_ft x 5_ft      |               | Braided   | 3x5      | W 6 x L 37 x H 6 | Oval      |     10 |  60.5 | 134.5 |        3186 |             112 | f         | NA                      | NA             | In_stock |        | N           | NA        | NA            |                0 |                   0 | 2022-01-13 19:33:41.513970
 200TAJT03 | 2606    | 2_ft 6_in x 6_ft |               | Braided   | Runner   | W 6 x L 31 x H 6 | Runner    |     10 |  68.7 | 152.7 |        1594 |              84 | f         | NA                      | NA             | In_stock |        | N           | NA        | NA            |                0 |                   0 | 2022-01-13 19:33:41.513970
*/
