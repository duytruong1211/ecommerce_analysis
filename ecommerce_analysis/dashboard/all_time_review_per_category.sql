select
    i.product_category,
    avg(o.avg_review_score)
from
    analysis.orders o
    inner join analysis.items i on i.order_id = o.order_id
where
     ('yes' = '{{ all_product }}' or product_category in ({{ product_category }}))
group by 1