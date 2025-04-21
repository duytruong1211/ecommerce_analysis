select
    date_trunc('{{ duration }}',o.order_approved_at)::date dates,
    product_category,
    count(distinct case when order_delivered_user_at::date > order_estimated_delivery_at then o.order_id else null end)*100.00/count(distinct o.order_id) as delayed_delivery_rate
from
    analysis.orders o
    inner join analysis.items i on o.order_id = i.order_id 
    -- inner join analysis.products p on i.product_id = p.product_id
where
    o.order_approved_at >= '2017-01-05' 
    and order_status = 'delivered'
    and ('yes' = '{{ all_product }}' or product_category in ({{ product_category }}))
group by 1,2




