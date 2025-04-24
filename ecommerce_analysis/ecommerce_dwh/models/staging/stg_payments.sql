
with cte as ( select * from {{ source('raw', 'olist_order_payments') }} )

SELECT
    --- create unique payment key
    order_id::text || payment_sequential payment_id,
    order_id,
    payment_sequential,
    payment_type,
    payment_installments,
    payment_value::decimal payment_value
FROM 
    cte

