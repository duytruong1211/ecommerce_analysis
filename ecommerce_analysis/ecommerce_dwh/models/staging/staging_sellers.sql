
with cte as ( select * from {{ source('raw', 'olist_sellers_dataset') }} )

SELECT
    customer_id user_order_id,
    customer_unique_id user_id,
    customer_zip_code_prefix first_five_zip,
    customer_city user_city,
    customer_state user_state
FROM 
    cte

