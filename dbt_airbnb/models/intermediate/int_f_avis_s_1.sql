{{ config(materialized='table') }}

with review_s_1 as (

    select * from {{ ref('stg_airbnb__review_S_1') }}

),

avis_s_1 as (

    select 
    LISTING_ID,
    ID,
    DATE,
    COMMENTS,
    analyse_json_note,
    analyse_json_note:global::string AS global,
    analyse_json_note:explication_global::string AS explication_global,
    analyse_json_note:prix::string AS prix,
    analyse_json_note:explication_prix::string AS explication_prix,
    analyse_json_note:localisation::string AS localisation,
    analyse_json_note:explication_localisation::string AS explication_localisation,
    analyse_json_note:qualite::string AS qualite,
    analyse_json_note:explication_qualite::string AS explication_qualite
    from 
    (
        select
        LISTING_ID,
        ID,
        DATE,
        COMMENTS,
        TRY_PARSE_JSON(
            REPLACE(REPLACE(
                SNOWFLAKE.CORTEX.COMPLETE(
                    'mistral-large',
                    'Donner une note de 1 à 5 pour ces commentaires de location de Airbnb. Je veux des réponses en français'
                    || 'La réponse doit être un seul objet JSON, rien d’autre, valide, sans retour chariot, '
                    || 'avec ces 8 champs en français : global, explication_global, prix, explication_prix, '
                    || 'localisation, explication_localisation, qualite, explication_qualite. '
					|| 'global, prix,localisation et qualite doivent être uniquement des nombre entre 1 et 5'
                    || 'Si la note n''est pas calculable, mettre null'
                    || 'Voici le commentaire: ' || COMMENTS
                ),
            '\n', ''), '\r', '')
        ) AS analyse_json_note
        from review_s_1
	    Where FG_DER_VER = 1
    ) review_notes

)

select * from avis_s_1