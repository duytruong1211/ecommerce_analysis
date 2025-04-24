{{ config(
    materialized='table',
    unique_key='order_id'
) }}
with orders as (select * from {{ ref('stg_orders') }} )
,order_users as (
select
    o.order_id,
    u.user_id,
    ROW_NUMBER() OVER (
        PARTITION BY u.user_id
        ORDER BY order_created_at ASC
    ) as order_sequentials,
    user_city,
    user_state
from 
    orders o
    inner join  {{ ref ('stg_users') }} u on o.user_order_id = u.user_order_id
)
, order_payments as (
SELECT
    p.order_id,
    count(p.payment_id) payment_numbers,
    string_agg(distinct payment_type, ', ' ORDER BY payment_type) payment_type

FROM
    {{ ref('stg_payments' )}} p
WHERE
    payment_type != 'not_defined'
GROUP BY 1

)
, order_items as (
SELECT
    i.order_id,
    count(item_sequential) item_numbers,
    sum(price) order_volume,
    sum(freight_value) freight_value,
    sum(price + freight_value) total_order_volume,
    min(shipping_limit_date_at) order_shipping_limit_date_at

FROM
    {{ ref ('stg_items' )}} i
GROUP BY 1
),
order_review as (
SELECT
    order_id,
    avg(review_score) avg_review_score
FROM
    {{ ref ('stg_reviews' )}}
GROUP BY
    1
)
select
    o.order_id,
    ui.user_id,
    order_sequentials,
    case when order_sequentials = 1 then 'new' else 'repeat' end as new_vs_repeat,
    item_numbers,
    order_status,
    order_volume,
    freight_value,
    total_order_volume,
    o.order_created_at,
    o.order_approved_at,
    o.order_delivered_carrier_at,
    o.order_delivered_user_at,
    order_estimated_delivery_at,
    order_shipping_limit_date_at,
    ui.user_city,
    ui.user_state,
    case when r.order_id is not null then 1 else  0 end as is_review,
    r.avg_review_score

from
    orders o
    left join order_users ui on o.order_id = ui.order_id
    left join order_payments op on o.order_id = op.order_id
    left join order_items oi on o.order_id = oi.order_id
    left join order_review r on o.order_id = r.order_id