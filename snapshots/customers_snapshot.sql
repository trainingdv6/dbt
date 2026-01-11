{% snapshot customers_snapshot %}
    {{
        config(
            target_schema='snapshots',
            unique_key='customer_key',
            strategy='timestamp',
            updated_at='_loaded_at',
        )
    }}
    select * from {{ ref('stg_customers') }}
{% endsnapshot %}