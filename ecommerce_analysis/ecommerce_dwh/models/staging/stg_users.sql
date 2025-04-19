
with cte as ( select * from {{ source('raw', 'olist_customers') }} )
--no null values so no need to transform
SELECT
    customer_unique_id user_id,
    customer_id user_order_id,
    customer_zip_code_prefix first_five_zip_user,
    unaccent(customer_city) user_city,
    customer_state user_state
FROM 
    cte

