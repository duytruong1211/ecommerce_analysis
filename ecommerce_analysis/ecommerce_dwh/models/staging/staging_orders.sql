
with cte as ( select * from {{ source('raw', 'olist_orders_dataset') }} )

SELECT
    order_id,
    order_status,    
    COALESCE(NULLIF(order_purchase_timestamp, ''), NULL)::timestamp order_purchase_at,
    COALESCE(NULLIF(order_approved_at, ''), NULL)::timestamp order_approved_at,
    COALESCE(NULLIF(order_delivered_carrier_date, ''), NULL)::timestamp order_delivered_carrier_at,
    COALESCE(NULLIF(order_delivered_customer_date, ''), NULL)::timestamp order_delivered_customer_at,
    COALESCE(NULLIF(order_estimated_delivery_date, ''), NULL)::timestamp order_estimated_delivery_at
FROM 
    cte

