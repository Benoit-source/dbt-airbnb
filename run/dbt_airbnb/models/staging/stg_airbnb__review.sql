
  create or replace   view AIRBNB_BI.BI_BRONZE.stg_airbnb__review
  
  
  
  
  as (
    with airbnb_bordeaux as (

    select *, 'Bordeaux', Decode (Rank() Over (Partition By ID, LISTING_ID Order BY DT_EVT Desc), 1 , 1, 0) As FG_DER_VER
    from AIRBNB_BI.RAW_AIRBNB_BORDEAUX.DBO_REVIEW

),

airbnb_lyon as (

    select *, 'Lyon', Decode (Rank() Over (Partition By ID, LISTING_ID Order BY DT_EVT Desc), 1 , 1, 0) As FG_DER_VER
    from AIRBNB_BI.RAW_AIRBNB_LYON.AIRBNB_REVIEW

),

airbnb_paris as (

    select *, 'Paris', Decode (Rank() Over (Partition By ID, LISTING_ID Order BY DT_EVT Desc), 1 , 1, 0) As FG_DER_VER
    from AIRBNB_BI.RAW_AIRBNB_PARIS.AIRBNB_REVIEW

),

airbnb_pays_basque as (

    select * , 'Pays Basque', Decode (Rank() Over (Partition By ID, LISTING_ID Order BY DT_EVT Desc), 1 , 1, 0) As FG_DER_VER
    from AIRBNB_BI.RAW_AIRBNB_PAYS_BASQUE.AIRBNB_REVIEW

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
  );

