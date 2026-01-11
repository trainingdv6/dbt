{{ config(
    materialized='table',
    tags=['marts', 'facts'],
    indexes=[
        {'columns': ['order_date'], 'type': 'btree'},
        {'columns': ['customer_key'], 'type': 'btree'}
    ]
) }}

select
    order_key,
    customer_key,
    order_date,
    order_status,
    count(line_number) as line_items_count,
    sum(quantity) as total_quantity,
    sum(extended_price) as gross_amount,
    sum(discounted_price) as net_amount,
    sum(final_price) as total_amount,
    avg(discount) as avg_discount_rate,
    sum(case when return_flag = 'R' then final_price else 0 end) as returned_amount
from {{ ref('int_order_items') }}
group by 1, 2, 3, 4