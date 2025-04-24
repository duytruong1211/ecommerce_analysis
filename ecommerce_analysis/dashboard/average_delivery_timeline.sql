with product_category as (
select distinct order_id
from
    analysis.items
where
   'yes' = '{{ all_product }}' or product_category in ({{ product_category }})
)
select
    date_trunc('{{ duration }}', o.order_approved_at)::date dates,
    avg( extract(epoch from order_delivered_carrier_at - order_approved_at) / 3600.00 /24 ) average_fullfilment_day,
    avg( extract(epoch from order_delivered_user_at - order_delivered_carrier_at) / 3600.00 /24 ) average_carrier_shipping_day
    -- avg( extract(epoch from order_estimated_delivery_at - order_delivered_user_at) / 3600.00 /24 ) average_difference_expected_actual
from
    analysis.orders o
    inner join product_category pc on o.order_id = pc.order_id
where
    order_status in( 'delivered','shipped')
    and o.order_approved_at >= '2017-01-05'
group by 1
    