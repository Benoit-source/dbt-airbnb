{% macro create_schema(relation) %}
-- Crée un schéma temporaire
{% set sql %}
  create schema if not exists {{ relation }}
{% endset %}

{% do run_query(sql) %}
{% endmacro %}
