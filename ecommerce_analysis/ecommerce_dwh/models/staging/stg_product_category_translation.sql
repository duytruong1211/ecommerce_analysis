
with cte as ( select * from {{ source('raw', ' product_category_name_translation') }} )
--no null values so no need to transform
SELECT
    product_category_name,
    product_category_name_english
FROM 
    cte

