
  create or replace   view AIRBNB_BI.BI_SILVER.int_d_price
  
  
  
  
  as (
    with listing as (

    select Distinct PRICE from AIRBNB_BI.BI_BRONZE.stg_airbnb__listing

),

price as (

    Select Distinct 
    Case When PRICE <= 50 Then 1
         When PRICE <= 100 Then 2
         When PRICE <= 200 Then 3
         When PRICE <= 500 Then 4
         When PRICE <= 1000 Then 5
        Else 6
        End CODE_TR_PRICE,
    Case When PRICE <= 50 Then '0-50€'
         When PRICE <= 100 Then '50-100€'
         When PRICE <= 200 Then '100-200€'
         When PRICE <= 500 Then '200-500€'
         When PRICE <= 1000 Then '500-1000€'
        Else '> 1000€'
        End TR_PRICE 
    from listing

)

select * from price
  );

