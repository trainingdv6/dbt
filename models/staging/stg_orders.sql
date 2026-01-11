{{ config(
    materialized='view',
    tags=['staging', 'orders']
) }}

select
    o_orderkey as order_key,
    o_custkey as customer_key,
    o_orderstatus as order_status,
    o_totalprice as total_price,
    o_orderdate as order_date,
    o_orderpriority as order_priority,
    o_clerk as clerk,
    o_shippriority as ship_priority,
    o_comment as comment,
    current_timestamp() as _loaded_at
from {{ source('tpch', 'orders') }}
where o_orderdate >= '{{ var("start_date") }}'
  and o_orderdate <= '{{ var("end_date") }}'