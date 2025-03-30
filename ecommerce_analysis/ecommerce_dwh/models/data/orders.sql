-- {{ config(
--     materialized='incremental',
--     unique_key='order_id'
-- ) }}
-- with users_info as (
-- select
--     o.order_id,
--     u.user_id,
--     ROW_NUMBER() OVER (
--         PARTITION BY customer_unique_id 
--         ORDER BY order_purchase_timestamp ASC
--     ) as order_number

-- from 
--     {{ ref('stg_orders') }} o
--     inner join  {{ ref ('stg_users') }} u on o.user_order_id = o.user_order_id
-- )

-- select
--     order_id,
--     user_id,
--     order_number,
--     case when order_number = 1 then 'new' else 'repeat' end as new_vs_repeat,

-- from
--     user_info ui