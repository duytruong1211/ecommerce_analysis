
with cte as ( select * from {{ source('raw', 'olist_sellers_dataset') }} )

SELECT
    seller_id,
    customer_zip_code_prefix first_five_zip_seller,
    unaccent(seller_city) seller_city,
    seller_state
FROM 
    cte

