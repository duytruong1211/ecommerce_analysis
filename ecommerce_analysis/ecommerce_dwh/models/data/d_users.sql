{{ config(
    materialized='table',
    unique_key = 'product_id'
) }}
with cte as (
select

from 
    {{ ref('stg_users') }} p
    )
select * from cte
