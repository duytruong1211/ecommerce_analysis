{{ config(
    materialized='table',
    unique_key='order_id'
) }}
with cte as (
select
    *
from 
 {{ ref('stg_orders') }}
)
select * from cte
