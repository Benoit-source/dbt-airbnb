{% macro create_schema(relation) %}
-- Crée un schéma temporaire
{% set sql %}
  create schema if not exists {{ relation }}
{% endset %}

{% do run_query(sql) %}

{% set sql %}
  CREATE TABLE IF NOT EXISTS AIRBNB_BI_FEATURE.BI.MODEL_RUN_LOG (
    MODEL_NAME        STRING,
    DATABASE_NAME     STRING,
    SCHEMA_NAME       STRING,
    MATERIALIZATION   STRING,
    TARGET_NAME       STRING,
    START_TIME        TIMESTAMP,
    END_TIME          TIMESTAMP,
    DURATION_SEC      NUMBER,
    STATUS            STRING,
    ERROR_MESSAGE     STRING,
    INVOCATION_ID     STRING
  )
{% endset %}

{% do run_query(sql) %}

{% endmacro %}
