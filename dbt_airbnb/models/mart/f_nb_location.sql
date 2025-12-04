with listing as (

    select ID, NUMBER_OF_REVIEWS, CODE_PRICE, CODE_VILLE, CODE_ROOM_TYPE 
    from {{ ref('int_f_location') }}

),

price as (

    Select CODE_TR_PRICE,
    TR_PRICE 
    from {{ ref('int_d_price') }}

),

town as (

    Select CODE_VILLE, VILLE 
    from {{ ref('int_d_town') }}

),

room as (

    Select CODE_ROOM_TYPE, ROOM_TYPE 
    from {{ ref('int_d_type_room') }}

),

agg as (

    Select TR_PRICE, VILLE, ROOM_TYPE, Count(Distinct ID) NB_AIRBNB, Sum(NUMBER_OF_REVIEWS) NB_REVIEW
    From listing 
    Inner Join price On price.CODE_TR_PRICE = listing.code_price
    Inner Join town On town.CODE_VILLE = listing.code_ville
    Inner Join room On room.CODE_ROOM_TYPE = listing.code_room_type
    Group By TR_PRICE, VILLE, ROOM_TYPE

)


select * from agg