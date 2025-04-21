SELECT
  CASE 
    WHEN order_volume <= 50 THEN 'Ultra Low'
    WHEN order_volume <= 150 THEN 'Low'
    WHEN order_volume <= 300 THEN 'Mid'
    WHEN order_volume <= 1000 THEN 'High'
    WHEN order_volume <= 5000 THEN 'Very High'
    ELSE 'Luxury'
  END AS price_bucket,
  CASE 
    WHEN order_volume <= 50 THEN 1
    WHEN order_volume <= 150 THEN 2
    WHEN order_volume <= 300 THEN 3
    WHEN order_volume <= 1000 THEN 4
    WHEN order_volume <= 5000 THEN 5
    ELSE 6
  END AS sort_key,
    product_category,
    count(distinct case when order_delivered_user_at::date > order_estimated_delivery_at then o.order_id else null end)*100.00/count(distinct o.order_id) as delayed_delivery_rate
from
    analysis.orders o
    inner join analysis.items i on o.order_id = i.order_id
    -- inner join analysis.products p on i.product_id = p.product_id
where
    order_status = 'delivered'
    and 'yes' = '{{ all_product }}' or product_category in ({{ product_category }})
group by 1,2,3




