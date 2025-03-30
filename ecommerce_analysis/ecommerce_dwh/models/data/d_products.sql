{{ config(
    materialized='table'
) }}
with cte as (
select
    p.product_id,
    pct.product_category_name_english product_category,
    
from 
    {{ ref('stg_products') }} p
    LEFT JOIN {{ ref('stg_product_category_translation') }} pct on p.product_category = pct.product_category
)
select * from cte
