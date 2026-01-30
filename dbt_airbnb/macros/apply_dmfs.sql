-- macros/apply_dmfs.sql
{% macro apply_dmfs(relation) %}

ALTER TABLE {{ relation }}
ADD DATA METRIC FUNCTION snowflake.core.null_count
ON (customer_id);

ALTER TABLE {{ relation }}
ADD DATA METRIC FUNCTION snowflake.core.duplicate_count
ON (order_id);

{% endmacro %}
