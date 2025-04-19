
with cte as ( select * from {{ source('raw', 'product_category_name_translation') }} )
SELECT
    product_category_name,
    case 
        when product_category_name_english = 'home_appliances_2' then 'home_appliances'
        when product_category_name_english = 'home_comfort_2' then 'home_comfort'
        when product_category_name_english = 'home_confort' then 'home_comfort'
    else product_category_name_english
    end as product_category_name_english
FROM 
    cte

