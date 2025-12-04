{% macro drop_schema_like(prefix) %}
{% set results = run_query("SHOW SCHEMAS LIKE '" ~ prefix ~ "%' IN DATABASE " ~ target.database) %}

{% if results %}
  {% for row in results.rows %}
    {% set schema_name = row[1] %}
    {% do run_query("DROP SCHEMA IF EXISTS " ~ schema_name ~ " CASCADE") %}
    {{ log("Dropped schema: " ~ schema_name, info=True) }}
  {% endfor %}
{% else %}
  {{ log("No schemas found with prefix: " ~ prefix, info=True) }}
{% endif %}
{% endmacro %}
