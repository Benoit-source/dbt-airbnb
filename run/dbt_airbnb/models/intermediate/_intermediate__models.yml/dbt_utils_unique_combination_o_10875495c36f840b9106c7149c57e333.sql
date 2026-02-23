
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  





with validation_errors as (

    select
        id, code_price
    from AIRBNB_BI_PROD.BI_SILVER.int_tab_inc_location
    group by id, code_price
    having count(*) > 1

)

select *
from validation_errors



  
  
      
    ) dbt_internal_test