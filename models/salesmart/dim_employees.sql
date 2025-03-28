{{ config(materialized = 'view', schema = 'salesmart_dev') }}
 
select
 *
 from 
 {{ref('stg_employees')}}
