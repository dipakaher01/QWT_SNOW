{{config(materialized = 'table', schema = env_var('DBT_TRANSFORMSCHEMA', 'TRANSFORMING_DEV'))}}
 
Select 
p.productid,
p.productname,
s.CompanyName as suppliercompany,
s.contactname as suppliercontact ,
s.city as suppliercity,
c.Categoryname,
p.quantityperunit,
p.unitcost,
p.unitprice,
p.unitsinstock,
p.unitsonorder,
IFF(p.unitsonorder > p.unitsinstock, 'Not Available', 'Available' ) as stockavailability
from 
{{ref("stg_products")}} as P
inner join
{{ref("trf_suppliers")}} as S
on p.SupplierID = s.SupplierID
inner join
{{ref("lkp_categories")}} as c
on c.CategoryID = p.CategoryID