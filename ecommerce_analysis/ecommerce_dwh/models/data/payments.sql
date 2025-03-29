{{ config(
    materialized='table',
    unique_key='payment_id'
) }}
with cte as (
select
    *
from 
 {{ ref('staging_payments') }}
)
select * from cte
