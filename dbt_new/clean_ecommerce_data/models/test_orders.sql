

{{ config(materialized='table') }}

SELECT
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp::date AS order_date
FROM {{ source('raw', 'olist_orders') }}
WHERE order_status NOT IN ('canceled', 'unavailable')
