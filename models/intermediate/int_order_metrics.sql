{{ config(materialized='view') }}

select
    order_key,
    customer_key,
    order_date,
    ship_date,
    {{ calculate_days_between('order_date', 'ship_date') }} as days_to_ship,
    final_price
from {{ ref('int_order_items') }}