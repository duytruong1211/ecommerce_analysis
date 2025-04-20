{{ config(
    materialized='table',
    unique_key = 'product_id'
) }}
with category as (
SELECT
    pct.product_category_name as sub_product_category,
    pct.product_category_name_english as sub_product_category_name_english,
    cm.product_category
FROM 
    {{ ref('stg_product_category_translation') }} pct
    inner join {{ ref('category_mapping') }} cm on cm.sub_product_category = pct.product_category_name_english
)
SELECT
    product_id,
    COALESCE(c.product_category,'Not Categorized') product_category,
    COALESCE(c.sub_product_category_name_english,'Not Categorized') sub_product_category_name_english,
    photos_number,
    weight_in_grams weight_in_g,
    COALESCE(length_in_cm,0) * COALESCE(height_in_cm,0) *COALESCE(width_in_cm,0)  product_size_cm3 
from 
    {{ ref('stg_products') }} p
    LEFT JOIN category c on p.product_category_name = c.sub_product_category