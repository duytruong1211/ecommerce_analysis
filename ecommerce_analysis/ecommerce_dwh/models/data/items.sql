{{ config(
    materialized='table',
    unique_key='item_id'
) }}
with cte as (
select  
    order_id::text || order_item_id::text as item_id,
    *
from 
 {{ ref('staging_items') }}
)
select * from cte
