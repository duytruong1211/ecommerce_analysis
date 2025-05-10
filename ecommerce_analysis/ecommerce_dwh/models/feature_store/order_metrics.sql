{{ config(
    materialized='table',
    unique_key='order_id',
    schema: feature_store
) }}
select
    o.order_id,
    o.order_created_at::date order_date_at,
    o.order_status,
    case when o.order_estimated_delivery_at::date < o.order_delivered_user_at::date then 1 else 0 end is_delayed,
    review_score,
    review_comment_message,
    
    extract(hour from o.order_delivered_user_at - o.order_delivered_carrier_at) shipping_time_in_hour,
    extract(hour from o.order_estimated_delivery_at - o.order_delivered_carrier_at) expected_shipping_time_in_hour,
    sum(i.price) total_price,
    sum(i.freight_value) shipping_cost,
    min(i.shipping_limit_date_at) order_shipping_limit_date_at,
    count(p.payment_id) payment_numbers,
    string_agg(distinct payment_type, ', ' ORDER BY payment_type) payment_type
from 
    {{ ref('stg_orders' )}} o 
    left join {{ ref('stg_items' )}}  i on o.order_id = i.order_id 
    left join {{ ref('stg_reviews' )}}  r on o.order_id = r.order_id 
    left join {{ ref('stg_payments' )}}  p on o.order_id = p.order_id and p.payment_type != 'not_defined'
group by 1,2,3,4,5,6,7,8


