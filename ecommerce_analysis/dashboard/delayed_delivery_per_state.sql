with product_category as (
select distinct order_id
from
    analysis.items
where
   'yes' = '{{ all_product }}' or product_category in ({{ product_category }})
)
select
    user_state,
    -- product_category,
    count(distinct case when order_delivered_user_at::date > order_estimated_delivery_at then o.order_id else null end)*100.00/count(distinct o.order_id) as delayed_delivery_rate
from
    analysis.orders o
    inner join product_category pc on o.order_id = pc.order_id
    -- inner join analysis.products p on i.product_id = p.product_id
where
    order_status = 'delivered'
group by 1
order by delayed_delivery_rate desc


