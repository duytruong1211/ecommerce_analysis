{{ config(
    materialized='table',
    unique_key = 'item_id'
) }}
with cte as (
select  
    i.*,
    o.order_approved_at,
    p.product_category
from 
 {{ ref('stg_items') }} i
 INNER JOIN {{ ref('stg_orders') }} o on i.order_id = o.order_id
 INNER JOIN {{ ref('products') }} p on p.product_id = i.product_id 
 )
select 
    item_id,
    order_id,
    item_sequential,
    seller_id,
    product_id,
    price,
    freight_value,
    shipping_limit_date_at item_shipping_limit_date_at,
    order_approved_at,
    product_category
from cte
