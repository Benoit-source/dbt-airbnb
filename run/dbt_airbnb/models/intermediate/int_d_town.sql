
  create or replace   view AIRBNB_BI.BI_SILVER.int_d_town
  
  
  
  
  as (
    with listing as (

    select Distinct VILLE from AIRBNB_BI.BI_BRONZE.stg_airbnb__listing

),

town as (

    Select Distinct 
    Case When VILLE = 'Bordeaux' Then 1
		 When VILLE = 'Lyon' Then 2
		 When VILLE = 'Paris' Then 3
		 When VILLE = 'Pays Basque' Then 4
	End CODE_VILLE,
	VILLE 
    from listing

)

select * from town
  );

