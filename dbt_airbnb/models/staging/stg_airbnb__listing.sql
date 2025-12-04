with airbnb_bordeaux as (

    select * exclude(LISTING_URL), 'Bordeaux' VILLE, Decode (Rank() Over (Partition By ID Order BY DT_EVT Desc), 1 , 1, 0) As FG_DER_VER
    from {{ source('AIRBNB_BORDEAUX', 'DBO_LISTING') }}

),

airbnb_lyon as (

    select * exclude(LISTING_URL,LIEN_URL), 'Lyon' VILLE, Decode (Rank() Over (Partition By ID Order BY DT_EVT Desc), 1 , 1, 0) As FG_DER_VER
    from {{ source('AIRBNB_LYON', 'AIRBNB_LISTING') }}

),

airbnb_paris as (

    select *, 'Paris' VILLE, Decode (Rank() Over (Partition By ID Order BY DT_EVT Desc), 1 , 1, 0) As FG_DER_VER
    from {{ source('AIRBNB_PARIS', 'AIRBNB_LISTING') }}

),

airbnb_pays_basque as (

    select * exclude(LISTING_URL), 'Pays Basque' VILLE, Decode (Rank() Over (Partition By ID Order BY DT_EVT Desc), 1 , 1, 0) As FG_DER_VER
    from {{ source('AIRBNB_PAYS_BASQUE', 'AIRBNB_LISTING') }}

),

table_union as (

    Select *
    From airbnb_bordeaux
    Union all
    Select *
    From airbnb_lyon
    Union all
    Select *
    From airbnb_paris
    Union all
    Select *
    From airbnb_pays_basque

)

select * from table_union
