with listing as (

    select ID, 
		PRICE,
		ROOM_TYPE,
		VILLE,
		LATITUDE,
		LONGITUDE,
		NUMBER_OF_REVIEWS,
		REVIEW_SCORES_ACCURACY,
		REVIEW_SCORES_CHECKIN,
		REVIEW_SCORES_CLEANLINESS,
		REVIEW_SCORES_COMMUNICATION,
		REVIEW_SCORES_LOCATION,
		REVIEW_SCORES_RATING,
		REVIEW_SCORES_VALUE 
	from {{ ref('stg_airbnb__listing') }}
	where FG_DER_VER = 1

),

liste as (

	Select ID, 
	Case When PRICE <= 50 Then 1
         When PRICE <= 100 Then 2
         When PRICE <= 200 Then 3
         When PRICE <= 500 Then 4
         When PRICE <= 1000 Then 5
        Else 6
        End CODE_PRICE,
	Case When ROOM_TYPE = 'Entire home/apt' Then 1
		When ROOM_TYPE = 'Private room' Then 2
		When ROOM_TYPE = 'Shared room' Then 3
		When ROOM_TYPE = 'Hotel room' Then 4
		End CODE_ROOM_TYPE,
    Case When VILLE = 'Bordeaux' Then 1
		 When VILLE = 'Lyon' Then 2
		 When VILLE = 'Paris' Then 3
		 When VILLE = 'Pays Basque' Then 4
	End CODE_VILLE,
	LATITUDE,
	LONGITUDE,
	NUMBER_OF_REVIEWS,
	REVIEW_SCORES_ACCURACY,
	REVIEW_SCORES_CHECKIN,
	REVIEW_SCORES_CLEANLINESS,
	REVIEW_SCORES_COMMUNICATION,
	REVIEW_SCORES_LOCATION,
	REVIEW_SCORES_RATING,
	REVIEW_SCORES_VALUE
    from listing

)

select * from liste