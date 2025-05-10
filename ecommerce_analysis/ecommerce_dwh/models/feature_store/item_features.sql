{{ config(
    materialized='table',
    unique_key='item_id',
    schema: feature_store
) }}
select
    i.item_id,
    i.order_id,
    i.seller_id,
    i.product_id,
    i.price,
    i.freight_value,
    i.shipping_limit_date_at,
    p.sub_product_category_name_english,
    p.product_category,
    p.weight_in_g,
    p.product_size_cm3,
    s.seller_state,
    s.seller_city
from
    {{ ref('stg_items' )}}  i 
    left join {{ ref('products' )}} p on i.product_id = i.product_id 
    left join {{ ref('stg_sellers' )}}  s on i.seller_id = s.seller_id


