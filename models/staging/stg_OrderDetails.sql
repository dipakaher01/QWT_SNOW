{{config(materialized = 'incremental', unique_key = ['OrderID', 'lineno'])}}
 
select 
od.OrderID,
od.lineno,
od.productid,
od.quantity,
od.unitprice,
od.discount,
o.orderdate
from
{{source('qwt_raw','raw_orders')}} as o
inner join 
{{source('qwt_raw','raw_OrderDetails')}} as od
on o.OrderID = od.OrderID

{% if is_incremental() %}

where o.orderdate > (select max(orderdate) from {{this}})

{% endif %}