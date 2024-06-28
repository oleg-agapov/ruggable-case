select * 
from public.product_searches
-- where surrogate_key = '127cfcb609ce0a372c79f1fd9c8841da'
limit 10
;

select surrogate_key, count(1) 
from public.stg_rugs_usa_variant
group by 1
having count(1) > 1
;

select *
from public.product_variants
where low_stock = 'false'
limit 10
;

select
    product_id,
    count(1) as available_colors
from public.product_colors
group by 1
limit 10
;

