{{ config(
    materialized='incremental',
    unique_key='order_id'
) }}
with users_info as (
SELECT
    
FROM
    {{ ref ('stg_users') }}

)
select
    *
from 
 {{ ref('stg_orders') }}
)
select * from cte
