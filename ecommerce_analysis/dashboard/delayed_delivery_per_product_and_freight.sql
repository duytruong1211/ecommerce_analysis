select
CASE 
    WHEN o.freight_value = 0 THEN 'Free'
    WHEN o.freight_value <= 10 THEN 'Low'
    WHEN o.freight_value <= 30 THEN 'Standard'
    WHEN o.freight_value <= 100 THEN 'High'
    ELSE 'Premium'
END AS freight_bucket,
CASE 
    WHEN o.freight_value = 0 THEN 1
    WHEN o.freight_value <= 10 THEN 2
    WHEN o.freight_value <= 30 THEN 3
    WHEN o.freight_value <= 100 THEN 4
    ELSE  5
END AS sort_key,
    product_category,
    count(distinct case when order_delivered_user_at::date > order_estimated_delivery_at then o.order_id else null end)*100.00/count(distinct o.order_id) as delayed_delivery_rate
from
    analysis.orders o
    inner join analysis.items i on o.order_id = i.order_id
    -- inner join analysis.products p on i.product_id = p.product_id
where
    order_status = 'delivered'
    and ('yes' = '{{ all_product }}' or product_category in ({{ product_category }}))
group by 1,2,3




