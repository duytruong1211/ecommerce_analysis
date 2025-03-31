{{ config(
    materialized='table',
    unique_key = 'product_id'
) }}
with users ( select * from {{ ref('stg_users') }} )
 
,user_order as (
select
    u.user_id,
    count(o.order_id) orders_count,
    
from 
    users
    inner join {{ ref ('stg_orders')}} o on u.user_order_id = o.user_order_id
    )
select * from cte
