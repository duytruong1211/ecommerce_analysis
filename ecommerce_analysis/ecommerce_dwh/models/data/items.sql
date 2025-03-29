{{ config(
    materialized='table'
) }}
with cte as (
select  

    *
from 
 {{ ref('stg_items') }}
)
select * from cte
