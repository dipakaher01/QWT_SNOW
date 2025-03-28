{% snapshot shipments_snapshot %}
{{ config
    (
        target_database = 'QWT_ANALYTICS_DEV',
        target_schema = 'SNAPSHOT_DEV',
        unique_key = " orderid || '-' || lineno",

        strategy = 'timestamp',
        updated_at = 'ShipmentDate'
        
    )
}}

Select * from {{ref('stg_shipments')}}
{% endsnapshot%}