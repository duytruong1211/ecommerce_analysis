{{ config(
    materialized='table',
    unique_key = 'product_id'
) }}
with cte as ( 
SELECT
    *
from 
    {{ ref('stg_products') }} p
    LEFT JOIN {{ ref('stg_product_category_translation') }} pct on p.product_category = pct.product_category_name
)
select
    product_id,
    product_category_name_english product_category,
    photos_number,
    weight_in_grams weight_in_g,
    COALESCE(length_in_cm,0) * COALESCE(height_in_cm,0) *COALESCE(width_in_cm,0)  product_size_cm3
from
    cte
