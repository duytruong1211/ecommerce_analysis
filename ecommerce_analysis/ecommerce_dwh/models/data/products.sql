{{ config(
    materialized='table',
    unique_key = 'product_id'
) }}
with cte as (
select
    p.product_id,
    pct.product_category_name_english product_category,
    p.photos_number,
    p.weight_in_grams weight_in_g,
    COALESCE(p.length_in_cm,0) * COALESCE(p.height_in_cm,0) *COALESCE(p.width_in_cm,0)  product_size_cm3
from 
    {{ ref('stg_products') }} p
    LEFT JOIN {{ ref('stg_product_category_translation') }} pct on p.product_category = pct.product_category_name
)
select * from cte
