-- Test that all orders have positive amounts
select order_key, total_amount
from {{ ref('fact_orders') }}
where total_amount <= 0