
with cte as ( select * from {{ source('raw', 'olist_marketing_qualified_leads_dataset') }} )
--no null values so no need to transform
SELECT
    mql_id,
    landing_page_id,
    NULLIF(origin,'') origin,
    NULLIF(first_contact_date, '')::timestamp first_contacted_at
FROM 
    cte

