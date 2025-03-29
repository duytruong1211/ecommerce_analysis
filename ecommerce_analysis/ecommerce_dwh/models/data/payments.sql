{{ config(
    materialized='table',
    unique_key='payment_id'
) }}
with cte as (
select
    *
from 
 {{ ref('stg_payments') }}
)
select * from cte
