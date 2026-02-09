
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select listing_id
from AIRBNB_BI.BI_BRONZE.stg_airbnb__review
where listing_id is null



  
  
      
    ) dbt_internal_test