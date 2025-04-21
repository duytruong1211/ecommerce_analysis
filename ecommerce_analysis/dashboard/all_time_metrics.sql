with product_category as (
select distinct order_id
from
    analysis.items
where
   'yes' = '{{ all_product }}' or product_category in ({{ product_category }})
)
select
    sum(case when order_delivered_user_at::date > order_estimated_delivery_at then 1 else 0 end)*100.00/count(*) as delayed_delivery_rate,
    avg( extract(epoch from order_delivered_carrier_at - order_approved_at) / 3600.00 /24 ) average_fullfilment_day,
    avg( extract(epoch from order_delivered_user_at - order_delivered_carrier_at) / 3600.00 /24 ) average_carrier_shipping_day,
    avg(avg_review_score) average_review_score,
    sum(case when order_delivered_carrier_at::date >= order_shipping_limit_date_at then 1 else 0 end)*100.00/count(*) as delayed_dispatch_rate
from
    analysis.orders o
    inner join product_category pc on o.order_id = pc.order_id
where
    order_status in ('delivered','shipped')
    and o.order_approved_at >= '2017-01-05'
-- group by 1




