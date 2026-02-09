
  create or replace   view AIRBNB_BI.BI_BRONZE.stg_airbnb__listing
  
    
    
(
  
    "DT_EVT" COMMENT $$$$, 
  
    "ID" COMMENT $$$$, 
  
    "SCRAPE_ID" COMMENT $$$$, 
  
    "LAST_SCRAPED" COMMENT $$$$, 
  
    "SOURCE" COMMENT $$$$, 
  
    "NAME" COMMENT $$$$, 
  
    "DESCRIPTION" COMMENT $$$$, 
  
    "NEIGHBORHOOD_OVERVIEW" COMMENT $$$$, 
  
    "PICTURE_URL" COMMENT $$$$, 
  
    "HOST_ID" COMMENT $$$$, 
  
    "HOST_URL" COMMENT $$$$, 
  
    "HOST_NAME" COMMENT $$$$, 
  
    "HOST_SINCE" COMMENT $$$$, 
  
    "HOST_LOCATION" COMMENT $$$$, 
  
    "HOST_ABOUT" COMMENT $$$$, 
  
    "HOST_RESPONSE_TIME" COMMENT $$$$, 
  
    "HOST_RESPONSE_RATE" COMMENT $$$$, 
  
    "HOST_ACCEPTANCE_RATE" COMMENT $$$$, 
  
    "HOST_IS_SUPERHOST" COMMENT $$$$, 
  
    "HOST_THUMBNAIL_URL" COMMENT $$$$, 
  
    "HOST_PICTURE_URL" COMMENT $$$$, 
  
    "HOST_NEIGHBOURHOOD" COMMENT $$$$, 
  
    "HOST_LISTINGS_COUNT" COMMENT $$$$, 
  
    "HOST_TOTAL_LISTINGS_COUNT" COMMENT $$$$, 
  
    "HOST_VERIFICATIONS" COMMENT $$$$, 
  
    "HOST_HAS_PROFILE_PIC" COMMENT $$$$, 
  
    "HOST_IDENTITY_VERIFIED" COMMENT $$$$, 
  
    "NEIGHBOURHOOD" COMMENT $$$$, 
  
    "NEIGHBOURHOOD_CLEANSED" COMMENT $$$$, 
  
    "NEIGHBOURHOOD_GROUP_CLEANSED" COMMENT $$$$, 
  
    "LATITUDE" COMMENT $$$$, 
  
    "LONGITUDE" COMMENT $$$$, 
  
    "PROPERTY_TYPE" COMMENT $$$$, 
  
    "ROOM_TYPE" COMMENT $$$$, 
  
    "ACCOMMODATES" COMMENT $$$$, 
  
    "BATHROOMS" COMMENT $$$$, 
  
    "BATHROOMS_TEXT" COMMENT $$$$, 
  
    "BEDROOMS" COMMENT $$$$, 
  
    "BEDS" COMMENT $$$$, 
  
    "AMENITIES" COMMENT $$$$, 
  
    "PRICE" COMMENT $$$$, 
  
    "MINIMUM_NIGHTS" COMMENT $$$$, 
  
    "MAXIMUM_NIGHTS" COMMENT $$$$, 
  
    "MINIMUM_MINIMUM_NIGHTS" COMMENT $$$$, 
  
    "MAXIMUM_MINIMUM_NIGHTS" COMMENT $$$$, 
  
    "MINIMUM_MAXIMUM_NIGHTS" COMMENT $$$$, 
  
    "MAXIMUM_MAXIMUM_NIGHTS" COMMENT $$$$, 
  
    "MINIMUM_NIGHTS_AVG_NTM" COMMENT $$$$, 
  
    "MAXIMUM_NIGHTS_AVG_NTM" COMMENT $$$$, 
  
    "CALENDAR_UPDATED" COMMENT $$$$, 
  
    "HAS_AVAILABILITY" COMMENT $$$$, 
  
    "AVAILABILITY_30" COMMENT $$$$, 
  
    "AVAILABILITY_60" COMMENT $$$$, 
  
    "AVAILABILITY_90" COMMENT $$$$, 
  
    "AVAILABILITY_365" COMMENT $$$$, 
  
    "CALENDAR_LAST_SCRAPED" COMMENT $$$$, 
  
    "NUMBER_OF_REVIEWS" COMMENT $$$$, 
  
    "NUMBER_OF_REVIEWS_LTM" COMMENT $$$$, 
  
    "NUMBER_OF_REVIEWS_L30D" COMMENT $$$$, 
  
    "AVAILABILITY_EOY" COMMENT $$$$, 
  
    "NUMBER_OF_REVIEWS_LY" COMMENT $$$$, 
  
    "ESTIMATED_OCCUPANCY_L365D" COMMENT $$$$, 
  
    "ESTIMATED_REVENUE_L365D" COMMENT $$$$, 
  
    "FIRST_REVIEW" COMMENT $$$$, 
  
    "LAST_REVIEW" COMMENT $$$$, 
  
    "REVIEW_SCORES_RATING" COMMENT $$$$, 
  
    "REVIEW_SCORES_ACCURACY" COMMENT $$$$, 
  
    "REVIEW_SCORES_CLEANLINESS" COMMENT $$$$, 
  
    "REVIEW_SCORES_CHECKIN" COMMENT $$$$, 
  
    "REVIEW_SCORES_COMMUNICATION" COMMENT $$$$, 
  
    "REVIEW_SCORES_LOCATION" COMMENT $$$$, 
  
    "REVIEW_SCORES_VALUE" COMMENT $$$$, 
  
    "LICENSE" COMMENT $$$$, 
  
    "INSTANT_BOOKABLE" COMMENT $$$$, 
  
    "CALCULATED_HOST_LISTINGS_COUNT" COMMENT $$$$, 
  
    "CALCULATED_HOST_LISTINGS_COUNT_ENTIRE_HOMES" COMMENT $$$$, 
  
    "CALCULATED_HOST_LISTINGS_COUNT_PRIVATE_ROOMS" COMMENT $$$$, 
  
    "CALCULATED_HOST_LISTINGS_COUNT_SHARED_ROOMS" COMMENT $$$$, 
  
    "REVIEWS_PER_MONTH" COMMENT $$$$, 
  
    "VILLE" COMMENT $$La ville dans laquelle se situe le **Airbnb**.$$, 
  
    "FG_DER_VER" COMMENT $$$$
  
)

  
  
  
  as (
    with airbnb_bordeaux as (

    select * exclude(LISTING_URL), 'Bordeaux' VILLE, Decode (Rank() Over (Partition By ID Order BY DT_EVT Desc), 1 , 1, 0) As FG_DER_VER
    from AIRBNB_BI.RAW_AIRBNB_BORDEAUX.DBO_LISTING

),

airbnb_lyon as (

    select * exclude(LISTING_URL,LIEN_URL), 'Lyon' VILLE, Decode (Rank() Over (Partition By ID Order BY DT_EVT Desc), 1 , 1, 0) As FG_DER_VER
    from AIRBNB_BI.RAW_AIRBNB_LYON.AIRBNB_LISTING

),

airbnb_paris as (

    select *, 'Paris' VILLE, Decode (Rank() Over (Partition By ID Order BY DT_EVT Desc), 1 , 1, 0) As FG_DER_VER
    from AIRBNB_BI.RAW_AIRBNB_PARIS.AIRBNB_LISTING

),

airbnb_pays_basque as (

    select * exclude(LISTING_URL), 'Pays Basque' VILLE, Decode (Rank() Over (Partition By ID Order BY DT_EVT Desc), 1 , 1, 0) As FG_DER_VER
    from AIRBNB_BI.RAW_AIRBNB_PAYS_BASQUE.AIRBNB_LISTING

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
    Select 	*
    From airbnb_pays_basque

)

select * from table_union
  );

