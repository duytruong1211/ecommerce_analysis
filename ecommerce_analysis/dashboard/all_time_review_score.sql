with product_category as (
select distinct order_id
from
    analysis.items
where
   'yes' = '{{ all_product }}' or product_category in ({{ product_category }})
)
select round(avg_review_score) review_score,
    count(*) number_of_review
from 
    analysis.orders o 
    inner join product_category pc on o.order_id = pc.order_id
group by 1