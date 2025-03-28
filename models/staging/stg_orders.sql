{{config(materialized = 'incremental', unique_key = 'OrderID')}}
 
select *
from
{{source('qwt_raw','raw_orders')}}
{% if is_incremental() %}

where orderdate > (select max(orderdate) from {{this}})

{% endif %}