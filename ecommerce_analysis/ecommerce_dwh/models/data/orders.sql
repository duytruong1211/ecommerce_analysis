{{ config(
    materialized='incremental',
    unique_key='order_id'
) }}
with orders as (select * from {{ ref('stg_orders') }} )
,users_info as (
select
    o.order_id,
    u.user_id,
    ROW_NUMBER() OVER (
        PARTITION BY customer_unique_id 
        ORDER BY order_purchase_timestamp ASC
    ) as order_number

from 
    orders o
    inner join  {{ ref ('stg_users') }} u on o.user_order_id = o.user_order_id
)
, orders_payment as (
SELECT
    p.order_id,
    count(p.payment_id) payments_number,
    string_agg(distinct payment_type, ', ' ORDER BY payment_type) payment_type

FROM
    {{ ref('stg_payments' )}} p
WHERE
    payment_type != 'not_defined'
GROUP BY 1

)
, orders_item as (
SELECT
    order_id,
    count(item_sequential) items_number,
    sum(price) order_volume,
    sum(freight_value) freight_volume,
    sum(price + freight_value) total_order_volume

FROM
    {{ ref ('stg_items' )}} i
GROUP BY 1
)
select
    order_id,
    user_id,
    order_number,
    case when order_number = 1 then 'new' else 'repeat' end as new_vs_repeat,

from
    orders o
    left join user_info ui on o.order_id = ui.order_id
    left join orders_payment op on ui.order_id = op.order_id