{{ config(
    materialized='table',
    tags=['marts', 'dimensions']
) }}

select
    customer_key,
    customer_name,
    market_segment,
    account_balance,
    total_orders,
    total_spent,
    avg_order_value,
    first_order_date,
    last_order_date,
    returned_amount,
    case 
        when total_spent >= 100000 then 'VIP'
        when total_spent >= 50000 then 'Gold'
        when total_spent >= 10000 then 'Silver'
        else 'Bronze'
    end as customer_tier,
    case 
        when last_order_date >= current_date - 90 then 'Active'
        when last_order_date >= current_date - 365 then 'Inactive'
        else 'Dormant'
    end as customer_status
from {{ ref('int_customer_metrics') }}