
with cte as ( select * from {{ source('raw', 'olist_products') }} )
--no null values so no need to transform
SELECT
    product_id,
    nullif(product_category_name,'') product_category_name,
    product_name_lenght name_length,
    product_description_lenght description_length,
    product_photos_qty photos_number,
    product_weight_g weight_in_grams,
    product_length_cm length_in_cm,
    product_height_cm height_in_cm,
    product_width_cm width_in_cm
FROM 
    cte


