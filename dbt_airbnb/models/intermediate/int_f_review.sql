with review as (

    select LISTING_ID,
	ID,
	DATE,
	COMMENTS 
	from {{ ref('stg_airbnb__review') }}
	where FG_DER_VER = 1

)

select * from review