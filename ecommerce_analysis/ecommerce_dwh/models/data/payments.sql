{{ config(
    materialized='table',
    unique_key='payment_id'
) }}
with cte as (
select
    order_id::text || payment_sequential::text payment_id,
    *
from 
 {{ ref('staging_payments') }}
)
select * from cte
