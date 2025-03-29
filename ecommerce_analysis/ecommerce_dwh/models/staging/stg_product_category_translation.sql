
with cte as ( select * from {{ source('raw', 'product_category_name_translation') }} )
SELECT
    product_category_name,
    product_category_name_english
FROM 
    cte

