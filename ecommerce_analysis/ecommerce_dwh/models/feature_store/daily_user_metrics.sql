{{ config(
    materialized='table',
    schema: feature_store
) }}
with daily_orders as (
select
    o.order_created_at::date daily_order_date,
    o.user_order_id,
    o.order_id,
    o.order_status,
    case when r.order_id is not null then 1 else 0 end is_review,
    sum(freight_value) shipping_cost,
    sum(price) order_price
from
    {{ ref('stg_orders' )}} o
    left join {{ ref('stg_items' )}} i on o.order_id = i.order_id
    left join {{ ref('stg_reviews' )}} r on o.order_id  = r.order_id
group by 1,2,3,4,5
    ),
cte as (
select
    date_day,
    u.user_id,
    max(is_review) is_review,
    count(o.order_id) order_count,
    sum(order_price) order_price
from
    {{ ref('dates' )}} d 
    left join daily_orders o on d.date_day = o.daily_order_date
    left join {{ ref('stg_users' )}} u on u.user_order_id = o.user_order_id
group by 1,2
    )
select 
    date_day,
    user_id,
    is_review,
    order_count,
    sum(order_count) over (partition by user_id order by date_day asc rows between UNBOUNDED PRECEDING AND CURRENT ROW) cul_order_count,
    case when sum(order_count) over (partition by user_id order by date_day asc rows between UNBOUNDED PRECEDING AND CURRENT ROW) >=2 then 1 else 0 end as repeat_user,
    order_price,
    sum(order_price) over (partition by user_id order by date_day asc rows between UNBOUNDED PRECEDING AND CURRENT ROW) cul_order_price,
    order_price*1.0/order_count aov,
    sum(order_price) over (partition by user_id order by date_day asc rows between UNBOUNDED PRECEDING AND CURRENT ROW)*1.0/
    sum(order_count) over (partition by user_id order by date_day asc rows between UNBOUNDED PRECEDING AND CURRENT ROW) cul_aov
from cte