
with cte as ( select * from {{ source('raw', 'olist_geolocation_dataset') }} )

SELECT
    geolocation_zip_code_prefix first_five_zip,
    geolocation_lat lat,
    geolocation_lng lng,
    geolocation_city city,
    geolocation_state state
FROM 
    cte

