with source as (

    select * from {{ source('public', 'rugs_usa_parent') }}

),

renamed as (

    select
        pid as product_id,
        product_type_id,
        name as product_name,
        url as product_url,
        origin,
        thickness,
        material,
        weave,
        weave_feature,
        color,
        brand,
        "imageName" as image_name,
        "imageType" as image_type,
        "internalName" as internal_name,
        category,
        min_price,
        max_price,
        availability,
        aggregate,
        clearance,
        long_description,
        shopbyroom as shop_by_room,
        dw_insert_timestamp

    from source

)

select * from renamed

/*
    pid     | product_type_id |          name           |                                  url                                   | origin | thickness |       material       | weave | weave_feature |   color    |  brand   | image_name |   image_type    |          internal_name           |   category    | min_price | max_price | availability | aggregate | clearance |                                                                                                                                                                                                                                                                                                                                                  long_description                                                                                                                                                                                                                                                                                                                                                  |                              shopbyroom                               |    dw_insert_timestamp     
------------+-----------------+-------------------------+------------------------------------------------------------------------+--------+-----------+----------------------+-------+---------------+------------+----------+------------+-----------------+----------------------------------+---------------+-----------+-----------+--------------+-----------+-----------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+-----------------------------------------------------------------------+----------------------------
 200TAJT03  | RUG             | Jute Braided            | /rugsusa/rugs/rugs-usa-jute-braided/Natural/200TAJT03-P.html           | India  | 1/4 inch  | 100% Jute            |       | Hand Woven    | Natural    | Rugs USA | 200TAJT03  | roomImage       | rugs-usa-jute-braided            | Maui          |         0 |         0 | 48 Hours     | t         | N         | This handmade 100% jute rug is a stylish and eco-friendly floor covering made from renewable material. Bring a warm, neutral look to any room, whether you seek a nautical rug, a boho rug, or anything in-between. This sophisticated floor piece can seamlessly integrate with any existing decor. This rug will be the perfect finishing touch to your living area. Choose from a wide array of colors and sizes. Make the most of your time at home with our pet-friendly and easy to clean area rugs.                                                                                                                                                                                                         | Bedroom, Dining Room, Living Room, Hallway, Office, Kitchen, Entryway | 2022-01-13 19:33:41.513542
 200CB01    | RUG             | Veronica Wool Braided   | /rugsusa/rugs/rugs-usa-veronica-wool-braided/Off-White/200CB01-P.html  | India  | 1/2 inch  | 80% Wool, 20% Cotton |       | Braided       | Off White  | Rugs USA | 200CB01    | roomImage       | rugs-usa-veronica-wool-braided   | Textures      |         0 |         0 | 48 Hours     | t         | N         | Handcrafted in the style of a chunky knit sweater, this felted cotton and wool rug provides delightful softness underfoot. The familiar knitted V pattern is rendered either in solid colors or variegated tones, providing a cozy look wherever you might want one. Designed to transform any space into your new oasis. Elevate your living space with our pet-friendly and easy to clean rugs.                                                                                                                                                                                                                                                                                                                  | Bedroom, Living Room                                                  | 2022-01-13 19:33:41.513542

*/
