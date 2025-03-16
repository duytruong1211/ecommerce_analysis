{{ config(
    materialized='table',
    unique_key='order_id'
) }}
with cte as (
select
    *
from 
 {{ ref('staging_orders') }}
)
select * from cte
