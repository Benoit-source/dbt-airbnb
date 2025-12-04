with listing as (

    select Distinct ROOM_TYPE from {{ ref('stg_airbnb__listing') }}

),

room as (

    select Distinct 
    Case When ROOM_TYPE = 'Entire home/apt' Then 1
        When ROOM_TYPE = 'Private room' Then 2
        When ROOM_TYPE = 'Shared room' Then 3
        When ROOM_TYPE = 'Hotel room' Then 4
        End CODE_ROOM_TYPE,
    ROOM_TYPE 
    from listing

)

select * from room