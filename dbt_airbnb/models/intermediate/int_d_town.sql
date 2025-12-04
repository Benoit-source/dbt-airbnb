with listing as (

    select Distinct VILLE from {{ ref('stg_airbnb__listing') }}

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