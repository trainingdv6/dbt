-- Customer Lifetime Value Analysis
{{ config(
    materialized='table'
) }}


with monthly_revenue as (
    select
        customer_key,
        date_trunc('month', order_date) as order_month,
        sum(total_amount) as monthly_revenue
    from {{ ref('fact_orders') }}
    group by 1, 2
),
customer_months as (
    select
        customer_key,
        count(distinct order_month) as active_months,
        avg(monthly_revenue) as avg_monthly_revenue,
        min(order_month) as first_month,
        max(order_month) as last_month
    from monthly_revenue
    group by 1
)
select
    cm.*,
    cm.avg_monthly_revenue * cm.active_months as estimated_ltv,
    {{ calculate_days_between('first_month', 'last_month') }} as customer_lifespan_days
from customer_months cm
order by estimated_ltv desc