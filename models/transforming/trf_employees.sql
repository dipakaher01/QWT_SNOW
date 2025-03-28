{{config(materialized = 'table', schema = env_var('DBT_TRANSFORMSCHEMA', 'TRANSFORMING_DEV'))}}
 

with recursive managers 

      -- Column names for the "view"/CTE

    (indent, employee_id, employee_name, employee_title, manager_id, manager_name, manager_title,office) 

    as

      -- Common Table Expression

      (
 
        -- Anchor Clause

        select '*' as indent, empid as employee_id, first_name as employee_name, title as employee_title, empid as manager_id, first_name as manager_name, title as manager_title,office

         from 
           {{ref('stg_employees')}}

          where title = 'President'
 
        union all
 
        -- Recursive Clause

        select indent || '*',

            e.empid as employee_id, e.first_name as employee_name, e.title as employee_title,

            m.employee_id, m.employee_name, m.employee_title,e.office

          from 

          {{ref('stg_employees')}} as e 

          join
          managers as m

            on e.reports_to = m.employee_id

      )
      
select indent, employee_id, employee_name, employee_title, manager_id, manager_name, manager_title,
so.OFFICE,
OFFICECITY,
IFF(OFFICESTATEPROVINCE is null,'NA',OFFICESTATEPROVINCE) as OFFICESTATE,
OFFICECOUNTRY
from {{ref('stg_offices')}}  SO
 left join managers on SO.OFFICE = managers.office

 