{{ config(
    materialized='view',
    tags=['intermediate', 'customers']
) }}

select
    c.customer_key,
    c.customer_name,
    c.market_segment,
    c.account_balance,
    count(distinct oi.order_key) as total_orders,
    sum(oi.final_price) as total_spent,
    avg(oi.final_price) as avg_order_value,
    min(oi.order_date) as first_order_date,
    max(oi.order_date) as last_order_date,
    sum(case when oi.return_flag = 'R' then oi.final_price else 0 end) as returned_amount
from {{ ref('stg_customers') }} c
left join {{ ref('int_order_items') }} oi
    on c.customer_key = oi.customer_key
group by 1, 2, 3, 4