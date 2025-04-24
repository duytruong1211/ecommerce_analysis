
with cte as ( select * from {{ source('raw', 'olist_orders') }} )

SELECT
    order_id,
    customer_id user_order_id,
    case when order_status = 'canceled' then 'cancelled' else order_status end as order_status,    
    NULLIF(order_purchase_timestamp, '')::timestamp order_created_at,
    NULLIF(order_approved_at, '')::timestamp order_approved_at,
    NULLIF(order_delivered_carrier_date, '')::timestamp order_delivered_carrier_at,
    NULLIF(order_delivered_customer_date, '')::timestamp order_delivered_user_at,
    NULLIF(order_estimated_delivery_date, '')::timestamp order_estimated_delivery_at
FROM 
    cte

