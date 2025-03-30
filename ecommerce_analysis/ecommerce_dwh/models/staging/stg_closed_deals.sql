
with cte as ( select * from {{ source('raw', 'olist_closed_deals_dataset') }} )
--no null values so no need to transform
SELECT
    mql_id,
    seller_id,
    sdr_id,
    sr_id,
    NULLIF(won_date,'') ::timestamp lead_won_at,
    NULLIF(business_segment,'') business_segment,
    NULLIF(lead_type,'') lead_type,
    NULLIF(lead_behavior_profile,'') lead_behavior_profile,
    NULLIF(has_company,'') is_company,
    NULLIF(has_gtin,'') is_gtin
FROM 
    cte

