{{ config(
    materialized='view',
    tags=['intermediate', 'orders']
) }}

select
    li.order_key,
    li.line_number,
    o.customer_key,
    o.order_date,
    o.order_status,
    li.quantity,
    li.extended_price,
    li.discount,
    li.tax,
    li.discounted_price,
    li.final_price,
    li.ship_date,
    li.return_flag,
    li.line_status
from {{ ref('stg_lineitems') }} li
inner join {{ ref('stg_orders') }} o
    on li.order_key = o.order_key