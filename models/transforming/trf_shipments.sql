{{config(materialized = 'table', schema = env_var('DBT_TRANSFORMSCHEMA', 'TRANSFORMING_DEV'))}}
 
 
select
 
c.orderid,
c.lineno,
d.companyname,
c.ShipmentDate,
c.Status as currentstatus

 
from
 {{ref('shipments_snapshot')}}  as c
 
inner join
 
{{ref('lkp_shipper')}} as d 
on c.shipperid = d.shipperid

where c.DBT_VALID_TO is null