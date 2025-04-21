with product_category as (
select distinct order_id
from
    analysis.items
where
   'yes' = '{{ all_product }}' or product_category in ({{ product_category }})
)
select
    date_trunc('{{ duration }}',o.order_approved_at)::date dates,
    sum(case when order_delivered_user_at::date > order_estimated_delivery_at  then 1 else 0 end)*100.00/count(*) as delayed_delivery_rate
from
    analysis.orders o
where
    order_status = 'delivered'
    and o.order_approved_at >= '2017-01-05'
group by 1




