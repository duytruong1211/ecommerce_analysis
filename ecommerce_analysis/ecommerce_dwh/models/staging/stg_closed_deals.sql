
with cte as ( select * from {{ source('raw', 'olist_closed_deals') }} )
--no null values so no need to transform
SELECT
    mql_id,
    seller_id,
    sdr_id,
    sr_id,
    NULLIF(won_date,'') ::timestamp lead_won_at,
    NULLIF(business_segment,'') business_segment,
    NULLIF(lead_type,'') lead_type,
    NULLIF(lead_behaviour_profile,'') lead_behaviour_profile,
    has_company is_company,
    has_gtin is_gtin,
    NULLIF(average_stock,'') average_stock,
    NULLIF(business_type,'') business_type,
    declared_product_catalog_size,
    declared_monthly_revenue

FROM 
    cte

