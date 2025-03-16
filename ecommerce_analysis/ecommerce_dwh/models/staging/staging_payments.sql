
with cte as ( select * from {{ source('raw', 'olist_order_payments_dataset') }} )

SELECT
    order_id,
    payment_sequential,
    payment_type,
    payment_installments,
    payment_values::decimal payment_values
FROM 
    cte

