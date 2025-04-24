{{ config(
    materialized='table',
    unique_key = 'seller_id'
) }}
with cte as ( select * from {{ ref('stg_sellers') }})

SELECT
    s.*
from
    cte s 
    left join {{ ref('stg_closed_deals') }} cd on s.seller_id = cd.seller_id
    left join {{ ref('stg_marketing_qualified_leads') }} l on l.mql_id = cd.mql_id
