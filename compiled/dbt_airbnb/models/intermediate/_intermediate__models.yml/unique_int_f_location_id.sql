
    
    

select
    id as unique_field,
    count(*) as n_records

from AIRBNB_BI.BI_SILVER.int_f_location
where id is not null
group by id
having count(*) > 1


