{% macro dmf_not_null(table_ref, column_name) %}
(
  SELECT
    COUNT_IF({{ column_name }} IS NULL)::FLOAT
    / NULLIF(COUNT(*), 0)
)
{% endmacro %}
