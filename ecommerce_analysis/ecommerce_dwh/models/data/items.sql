{{ config(
    materialized='table'
) }}
with cte as (
select  

    *
from 
 {{ ref('staging_items') }}
)
select * from cte
