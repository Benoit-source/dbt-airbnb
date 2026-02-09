{% macro attach_dmfs(table_name, dmfs) %}

{% for dmf in dmfs %}
ALTER TABLE {{ this.database }}.{{ this.schema }}.{{ table_name }}
ADD DATA METRIC FUNCTION {{ dmf.name }}
ON ({{ dmf.column }});
{% endfor %}

{% endmacro %}
