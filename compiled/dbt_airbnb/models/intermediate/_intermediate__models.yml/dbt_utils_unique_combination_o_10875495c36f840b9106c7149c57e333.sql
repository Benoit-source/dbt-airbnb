





with validation_errors as (

    select
        id, code_price
    from AIRBNB_BI.BI_SILVER.int_tab_inc_location
    group by id, code_price
    having count(*) > 1

)

select *
from validation_errors


