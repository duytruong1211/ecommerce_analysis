with cte as (select * from  {{ source('raw', 'olist_order_items') }} )
select
    -- create unique item key
    order_id::text || order_item_id item_id,
    order_id,
    order_item_id item_sequential,
    seller_id,
    product_id,
    price::decimal price,
    freight_value::decimal freight_value,
    NULLIF(shipping_limit_date, '')::timestamp shipping_limit_date_at
from
    cte