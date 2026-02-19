
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select id
from AIRBNB_BI.BI_SILVER.int_tab_inc_location
where id is null



  
  
      
    ) dbt_internal_test